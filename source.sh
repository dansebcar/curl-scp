BASE_DIR=$(dirname $(realpath "${BASH_SOURCE[0]}"))
IMAGE_NAME=ammonitor-image

build() {
	local -a args=(
		--build-arg AUTHORIZED_KEY
		--tag $IMAGE_NAME
		"$BASE_DIR"
	)
	docker build "${args[@]}"
}

run() {
	local -a args=(
		-it
		--network host
		--rm
		$IMAGE_NAME
	)
	docker run "${args[@]}"
}

up() {
	build && run
}
