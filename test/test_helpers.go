package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/testing"
	"github.com/stretchr/testify/assert"
)

func ensureZeroResourceChange(t testing.TestingT, options *terraform.Options) {
	// Ensure there's no drift on the next plan
	resourceCount := terraform.GetResourceCount(t, terraform.InitAndPlan(t, options))
	assert.Zero(t, resourceCount.Add, "Expected zero resources to add, got ", resourceCount.Add)
	assert.Zero(t, resourceCount.Change, "Expected zero resources to change, got ", resourceCount.Change)
	assert.Zero(t, resourceCount.Destroy, "Expected zero resources to destroy, got ", resourceCount.Destroy)

}
