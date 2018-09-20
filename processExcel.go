package main

import (
	"encoding/csv"
	"fmt"
	"github.com/tealeg/xlsx"
	"io/ioutil"
	"os"
	"strings"
)

func processFile(filePath string) map[int][]string {
	fmt.Println("Processing file")
	fmt.Println(filePath)
	xlFile, err := xlsx.OpenFile(filePath)
	dataToReturn := make(map[int][]string)
	if err != nil {
		fmt.Println("fatal error opening")
	}
	for i, sheet := range xlFile.Sheets {
		var data [5]string
		clientName := sheet.Name
		billDate := sheet.Cell(26, 7)
		serviceName := sheet.Cell(31, 2)
		nettoValue := sheet.Cell(34, 4)
		data[0] = clientName
		data[1] = billDate.Value
		data[2] = serviceName.Value
		data[3] = nettoValue.Value
		var dataSlice []string = data[0:4]
		dataToReturn[i] = dataSlice
	}
	return dataToReturn
}

func main() {
	dir, _ := os.Getwd()
	files, _ := ioutil.ReadDir("./")
	for _, f := range files {
		fileName := f.Name()
		if strings.Contains(fileName, "xlsx") {
			data := processFile(dir + "/" + fileName)
			csvFileName := strings.Replace(fileName, "xlsx", "csv", -1)
			file, _ := os.Create(csvFileName)
			defer file.Close()
			writer := csv.NewWriter(file)
			writer.Comma = '|'
			defer writer.Flush()
			for _, value := range data {
				err := writer.Write(value)
				if err != nil {
					fmt.Println("Error writing value")
				}
			}
		}
	}
}
