package dbtdemo

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestStuff(t *testing.T) {
	fmt.Printf("Life is a test.\nIt is only a test.\nHad this been your real life, you would have been given better instructions.\n")
	assert.True(t, 1 == 1, "Uh oh.  We have a serious problem.")
}
