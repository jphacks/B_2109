package http

import (
	"context"
	"encoding/json"
	"errors"
	"io/ioutil"
	"log"
	"math"
	"net/http"
	"time"

	"gorm.io/gorm"

	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/jphacks/B_2109/server/pkg/repos"
)

type ReadEventReq struct {
	Start      int `json:"start"`
	End        int `json:"end"`
	StartWidth int `json:"start_width"`
	EndWidth   int `json:"end_width"`
	BookmarkID int `json:"bookmark_id"`
}

type ProgReq struct {
	UserID uint `json:"user_id"`
}

type Response struct {
	Status string `json:"status"`
	Data   string `json:"data"`
}

type ProgResponse struct {
	Status string  `json:"status"`
	Data   float64 `json:"data"`
}

func CreateReadEventHander(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
	w.Header().Set("Content-Type", "application/json; charset=utf8")

	body, _ := ioutil.ReadAll(r.Body)

	re := ReadEventReq{
		Start:      0,
		End:        0,
		StartWidth: 0,
		EndWidth:   0,
		BookmarkID: 0,
	}
	//json.Unmarshal(body, &re)
	//log.Printf("[DEBUG] re body %v", string(body))
	//log.Printf("[DEBUG] re req %v", re)
	//log.Printf("[DEBUG] r header %v", r.Header)
	var f interface{}

	json.Unmarshal(body, &f)
	log.Printf("[DEBUG] re f %v", f)
	log.Printf("[DEBUG] re f type %T", f)
	//m := f.(map[string]interface{})
	//log.Printf("[DEBUG] re m %v", m)
	//re.Start = m["start"].(int)
	//re.Start = m["end"].(int)
	//re.Start = m["start_width"].(int)
	//re.Start = m["end_width"].(int)
	//re.Start = m["bookmark)id"].(int)
	//log.Printf("[DEBUG] re rf %v", re)
	json.Unmarshal([]byte(f.(string)), &re)

	err := createReadEvent(uint(re.BookmarkID), time.Unix(int64(re.Start), 0), time.Unix(int64(re.End), 0), int64(re.StartWidth), int64(re.EndWidth))

	resp := Response{}
	if err != nil {
		resp.Status = "error"
		resp.Data = err.Error()
	} else {
		resp.Status = "ok"
		resp.Data = "success"
	}
	j, _ := json.Marshal(resp)
	w.Write(j)
}

func createReadEvent(bookmark uint, start, end time.Time, startWidth, endWidth int64) error {
	//ub, err := getReadingStatusUserBookByBookmarkID(bookmark)
	//if err != nil {
	//	return err
	//}
	bmr := repos.NewBookmarkRepository()
	bm, err := bmr.GetByID(context.Background(), bookmark)
	if err != nil {
		return err
	}
	ub := models.UserBook{Model: gorm.Model{ID: bm.UserBookID}}
	re := models.ConstructReadEvent(ub, start, end, startWidth, endWidth)
	rer := repos.NewReadEventRpository()
	err = rer.Create(context.Background(), re)
	return err
}

func getReadingStatusUserBookByBookmarkID(id uint) (*models.UserBook, error) {
	ubr := repos.NewUserBookRepository()
	ubs, err := ubr.GetByBookmarkID(context.Background(), id)
	if err != nil {
		return nil, err
	}

	for _, ub := range ubs {
		if ub.ReadStatus == models.READ_STATUS_READING {
			return &ub, nil
		}
	}
	return nil, errors.New("reading userbook is not found")
}

func GetProgressByUserIDHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("GetProgressByUserIDHandler reached")
	pr := ProgReq{}

	w.WriteHeader(200)
	w.Header().Set("Content-Type", "application/json; charset=utf8")

	body, _ := ioutil.ReadAll(r.Body)
	var f interface{}

	json.Unmarshal(body, &f)
	log.Printf("[DEBUG] re f %v", f)
	log.Printf("[DEBUG] re f type %T", f)
	//json.Unmarshal(body, &pr)
	json.Unmarshal([]byte(f.(string)), &pr)

	log.Printf("http GetProgressByUserIDHandler pr %v", pr)

	prog, err := getProgressByUserID(pr.UserID)
	log.Printf("[DEBUG] prog %v", prog)

	//resp := Response{}
	//if err != nil {
	//	resp.Status = "error"
	//	resp.Data = err.Error()
	//} else {
	//	resp.Status = "ok"
	//	resp.Data = strconv.FormatFloat(prog, 'f', 2, 64)
	//}
	resp := ProgResponse{}
	if err != nil {
		log.Printf("[ERROR] %v", err)
		resp.Status = "error"
		resp.Data = 0
	} else {
		resp.Status = "ok"
		resp.Data = prog
		//resp.Data = 0.333
	}
	j, _ := json.Marshal(resp)
	w.Write(j)
}

func getProgressByUserID(id uint) (float64, error) {
	r := repos.NewUserBookRepository()
	log.Printf("[DEBUG] getProgressByUserID id %v", id)
	ubs, err := r.GetByUserID(context.Background(), id)
	if err != nil {
		return 0, err
	}
	log.Println(ubs)

	total := 0
	readTotal := 0.0
	for _, ub := range ubs {
		readTotalRatio := 0.0
		maxLevel := 0
		ub.ReadEvents = getReadEvents(ub.ID)
		for _, e := range ub.ReadEvents {
			maxLevel = int(math.Max(float64(maxLevel), float64(e.ReadEndWidthLevel)))
		}
		log.Printf("maxLevel %v", maxLevel)
		log.Printf("WidthLevel %v", ub.WidthLevel)
		if ub.WidthLevel == 0 {
			return 0, nil
		}
		readTotalRatio += float64(maxLevel) / float64(ub.WidthLevel)
		//readTotalRatio += float64(maxLevel) / float64(770)
		log.Printf("readTotalRatio %v", readTotalRatio)

		br := repos.NewBookRepository()
		book, _ := br.GetByID(context.Background(), ub.ID)
		total += int(book.Pages)
		readTotal += readTotalRatio * float64(book.Pages)
	}
	log.Printf("readTotal %v", readTotal)
	log.Printf("total %v", total)
	if total == 0 {
		return 0, nil
	}

	return readTotal / float64(total), nil
}

func getReadEvents(userBookID uint) []models.ReadEvent {
	rer := repos.NewReadEventRpository()
	res, err := rer.GetByUserBookID(context.Background(), userBookID)
	log.Println(err)
	return res
}
