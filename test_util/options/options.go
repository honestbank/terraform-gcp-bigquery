package options

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

type Builder terraform.Options

func NewBuilder(t *testing.T, directory string) *Builder {
	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: directory,
		Vars:         make(map[string]interface{}),
	})

	return (*Builder)(options)
}

func (o *Builder) WithInput(key string, value interface{}) *Builder {
	o.Vars[key] = value

	return o
}

func (o *Builder) Build() *terraform.Options {
	return (*terraform.Options)(o)
}
