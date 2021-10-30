package openbd

import (
	"context"
	"strconv"

	"github.com/jphacks/B_2109/server/pkg/models"
	"github.com/osamingo/openbd"
)

func FetchBook(ctx context.Context, isbn string) (*models.Book, error) {
	cli, err := openbd.NewClientV1("https://api.openbd.jp", nil)
	if err != nil {
		return nil, err
	}

	bs, err := cli.Get(isbn)
	if err != nil {
		return nil, err
	}
	b := bs[isbn]
	root := b.(*openbd.Root)
	pages, err := getPageNum(root)
	if err != nil {
		return nil, err
	}
	price, err := getPrice(root)
	if err != nil {
		return nil, err
	}

	as := getAuthors(root)
	return models.ConstructBook(isbn, b.Title(), pages, price, as, b.Cover()), nil
}

func getPageNum(root *openbd.Root) (int64, error) {
	return strconv.ParseInt(root.Onix.DescriptiveDetail.Extent[0].ExtentValue, 10, 64)
}

func getPrice(root *openbd.Root) (int64, error) {
	return strconv.ParseInt(root.Onix.ProductSupply.SupplyDetail.Price[0].PriceAmount, 10, 64)
}

func getAuthors(root *openbd.Root) []*models.Author {
	var as []*models.Author

	for _, c := range root.Onix.DescriptiveDetail.Contributor {
		as = append(as, models.ConstructAuthor(c.PersonName.Content))
	}
	return as
}
