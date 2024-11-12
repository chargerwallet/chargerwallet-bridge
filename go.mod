module chargerwallet.com/bridge

go 1.19

require (
	github.com/chargerwallet/chargerwallet-bridge
	github.com/gorilla/csrf v1.5.1
	github.com/gorilla/handlers v1.3.0
	github.com/gorilla/mux v1.6.1
	gopkg.in/natefinch/lumberjack.v2 v2.0.0-20170531160350-a96e63847dc3
)

require (
	github.com/BurntSushi/toml v1.2.1 // indirect
	github.com/gorilla/context v1.1.1 // indirect
	github.com/gorilla/securecookie v1.1.1 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
)

replace github.com/chargerwallet/chargerwallet-bridge => ./

replace github.com/chargerwallet/chargerwallet-bridge/core => ./core

replace github.com/chargerwallet/chargerwallet-bridge/memorywriter => ./memorywriter

replace github.com/chargerwallet/chargerwallet-bridge/server => ./server

replace github.com/chargerwallet/chargerwallet-bridge/usb => ./usb
