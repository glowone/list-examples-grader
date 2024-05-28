CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Navigate to the cloned repository
cd student-submission

# Compile the student's Java code
javac -cp $CPATH ListExamples.java

# Run the tests against the compiled code
test_results=$(java -cp $CPATH org.junit.runner.JUnitCore ListExamplesTest)

# Calculate the grade
total_tests=$(echo "$test_results" | grep -o 'run: [0-9]*' | awk '{print $2}')
failed_tests=$(echo "$test_results" | grep -o 'failed: [0-9]*' | awk '{print $2}')
passed_tests=$((total_tests - failed_tests))

grade=$((passed_tests * 100 / total_tests))
echo "Grade: $grade%"
