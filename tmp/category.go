package tmp

import "gorm.io/gorm"

type Category struct {
	gorm.Model
	Name string
}

type Categories []Category

func (cs Categories) GetCategoryNameSlice() []string {
	var names []string

	for _, c := range cs {
		names = append(names, c.Name)
	}
	return names
}
