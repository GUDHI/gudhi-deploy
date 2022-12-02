.SILENT: help

help:
	echo 'help - display this menu'
	echo '============================================================================'
	echo 'login - log to docker hub, requires an account and credentials on https://hub.docker.com/orgs/gudhi/repositories'
	echo 'build_circleci - build docker images for circleci'
	echo 'build_pip - build docker images for github actions to build gudhi pip linux package'
	echo 'build_latest - build docker images with latest gudhi version'
	echo 'push_circleci - push docker images for circleci'
	echo 'push_pip - push docker images for github actions to build gudhi pip linux package'
	echo 'push_latest - push docker images with latest gudhi version'
	echo 'circleci - build, login and push docker images for circleci'
	echo 'pip - build, login and push docker images for github actions to build gudhi pip linux package'
	echo 'latest - build, login and push docker images with latest gudhi version'
	echo 'all - all...'

login:
	docker login

build_circleci:
	docker build -t gudhi/ci_for_gudhi -f Dockerfile_for_circleci_image .
	docker build -t gudhi/doxygen_for_gudhi -f Dockerfile_for_doxygen_circleci_image .
	docker build -t gudhi/ci_for_gudhi_wo_cgal -f Dockerfile_for_circleci_image_without_cgal .

build_pip:
	docker build -t gudhi/pip_for_gudhi -f Dockerfile_for_pip .

build_latest:
	docker build -t gudhi/latest_gudhi_version -f Dockerfile_for_gudhi_installation .

push_circleci:
	docker push gudhi/ci_for_gudhi
	docker push gudhi/doxygen_for_gudhi
	docker push gudhi/ci_for_gudhi_wo_cgal

push_pip:
	docker push gudhi/pip_for_gudhi

push_latest:
	docker push gudhi/latest_gudhi_version

circleci: build_circleci login push_circleci

pip: build_pip login push_pip

latest: build_latest login push_latest

all: build_circleci build_pip build_latest login push_circleci push_pip push_latest