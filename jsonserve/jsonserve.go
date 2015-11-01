package main

import (
	"github.com/ant0ine/go-json-rest/rest"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"log"
	"net/http"
	"time"
)

type Service struct {
	Id        int64     `json:"id"`
  ChartType string    `sql:"size:50" json:"chart_type"`
  Name      string    `sql:"size:1024" json:"name"`
	Json      string    `sql:"size:1..5000" json:"json"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

type Impl struct {
	DB gorm.DB
}

func (i *Impl) InitDB() {
	var err error
	i.DB, err = gorm.Open("mysql", "root:@/movies?charset=utf8&parseTime=True")
	if err != nil {
		log.Fatalf("Got error when connect database, the error is '%v'", err)
	}
	i.DB.LogMode(true)
}

func (i *Impl) InitSchema() {
	i.DB.AutoMigrate(&Service{})
}

func (i *Impl) GetAllServices(w rest.ResponseWriter, r *rest.Request) {
	services := []Service{}
	i.DB.Find(&services)
	w.WriteJson(&services)
}

func (i *Impl) GetService(w rest.ResponseWriter, r *rest.Request) {
	id := r.PathParam("id")
	service := Service{}
	if i.DB.First(&service, id).Error != nil {
		rest.NotFound(w, r)
		return
	}
	w.WriteJson(&service)
}

func (i *Impl) PostService(w rest.ResponseWriter, r *rest.Request) {
	service := Service{}
	if err := r.DecodeJsonPayload(&service); err != nil {
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	if err := i.DB.Save(&service).Error; err != nil {
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteJson(&service)
}

func (i *Impl) PutService(w rest.ResponseWriter, r *rest.Request) {

	id := r.PathParam("id")
	service := Service{}
	if i.DB.First(&service, id).Error != nil {
		rest.NotFound(w, r)
		return
	}

	updated := Service{}
	if err := r.DecodeJsonPayload(&updated); err != nil {
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	service.Name = updated.Name
	service.Json = updated.Json

	if err := i.DB.Save(&service).Error; err != nil {
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteJson(&service)
}

func (i *Impl) DeleteService(w rest.ResponseWriter, r *rest.Request) {
	id := r.PathParam("id")
	service := Service{}
	if i.DB.First(&service, id).Error != nil {
		rest.NotFound(w, r)
		return
	}
	if err := i.DB.Delete(&service).Error; err != nil {
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
}

func main() {
	i := Impl{}
	i.InitDB()
	i.InitSchema()

	api := rest.NewApi()
	api.Use(rest.DefaultDevStack...)
	router, err := rest.MakeRouter(
		rest.Get("/services", i.GetAllServices),
	)
	if err != nil {
		log.Fatal(err)
	}
	api.SetApp(router)
	log.Fatal(http.ListenAndServe(":8080", api.MakeHandler()))
}
