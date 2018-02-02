NAME = Classmere
SCHEME = Classmere
SDK = iphonesimulator
DEST = iPhone X

all: build test

build: $(NAME).xcworkspace
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		build | xcpretty

build-for-testing: $(NAME).xcworkspace
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		build-for-testing | xcpretty

test: build-for-testing
	set -o pipefail && xctool \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		run-tests

clean:
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		clean
