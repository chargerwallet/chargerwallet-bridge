package api

import (
	"testing"
)

// Test the origin validation
func TestOriginValidator(t *testing.T) {
	testcases := []struct {
		origin string
		allow  bool
	}{
		// Should be allowed
		{"https://trezor.io", true},
		{"https://foo.trezor.io", true},
		{"https://bar.foo.trezor.io", true},
		// Should be denied
		{"https://faketrezor.io", false},
		{"https://foo.faketrezor.io", false},
		{"https://foo.trezor.ioo", false},
		{"http://foo.trezor.io", false},
		// Localhost 8xxx and 5xxx should be allowed for local development
		{"https://localhost:8000", true},
		{"http://localhost:8000", true},
		{"http://localhost:8999", true},
		{"https://localhost:5000", true},
		{"http://localhost:5000", true},
		{"http://localhost:5999", true},
		// Other ports denied
		{"http://localhost", false},
		{"http://localhost:1234", false},
		// for chargerwallet subdomains
		{"https://firmware.chargerwallet.com", true},
		{"http://firmware.chargerwallet.com", false},
		{"https://other.chargerwallet.com", true},
		// for chargerwalletcn subdomains
		{"https://firmware.chargerwalletcn.com", true},
		{"http://firmware.chargerwalletcn.com", false},
		{"https://other.chargerwalletcn.com", true},
	}
	validator, err := corsValidator()
	if err != nil {
		t.Fatal(err)
	}
	for _, tc := range testcases {
		allow := validator(tc.origin)
		if allow != tc.allow {
			t.Errorf("Origin %q: expected %v, got %v", tc.origin, tc.allow, allow)
		}
	}
}
