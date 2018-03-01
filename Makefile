NAME = Classmere
SCHEME = Classmere
SDK = iphonesimulator
DEST = iPhone X

all: build test

# Fetch Pods before doing anything else
.PHONY: $(NAME).xcworkspace
$(NAME).xcworkspace:
	bundle exec pod install

build: $(NAME).xcworkspace
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		build | bundle exec xcpretty

build-for-testing: $(NAME).xcworkspace
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		build-for-testing | bundle exec xcpretty

test: build-for-testing
	set -o pipefail && xctool \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		-destination 'name=$(DEST),OS=latest' \
		run-tests

lint: $(NAME).xcworkspace
	Pods/Swiftlint/swiftlint

clean:
	set -o pipefail && xcodebuild \
		-workspace $(NAME).xcworkspace \
		-scheme $(SCHEME) \
		-sdk $(SDK) \
		clean
