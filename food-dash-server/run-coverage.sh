
export CC_TEST_REPORTER_ID=038c872feefaf775807be55fe2cf4138b7b523b7e72a76e5e63f561a616d2e0d
export JACOCO_SOURCE_PATH=src/main/java
printenv
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter

./cc-test-reporter before-build
mvn --no-transfer-progress clean verify package

./cc-test-reporter format-coverage target/site/jacoco/jacoco.xml --input-type jacoco

./cc-test-reporter upload-coverage
