
export CC_TEST_REPORTER_ID=UPDATE_THIS_WITH_REPORTER_ID
export JACOCO_SOURCE_PATH=src/main/java
printenv
# curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
# chmod +x ./cc-test-reporter

# ./cc-test-reporter before-build
mvn --no-transfer-progress clean verify package

# ./cc-test-reporter format-coverage target/site/jacoco/jacoco.xml --input-type jacoco

# don't try to output coverage until the CC_TEST_REPORTER_ID is set properly
# ./cc-test-reporter upload-coverage
