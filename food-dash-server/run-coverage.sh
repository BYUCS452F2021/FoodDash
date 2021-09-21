
export CC_TEST_REPORTER_ID=test
export JACOCO_SOURCE_PATH=src/main/java
printenv
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
chmod +x ./cc-test-reporter

./cc-test-reporter before-build
mvn --no-transfer-progress clean verify package

./cc-test-reporter format-coverage target/site/jacoco/jacoco.xml --input-type jacoco

./cc-test-reporter upload-coverage
