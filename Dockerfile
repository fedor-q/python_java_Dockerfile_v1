FROM fedordqa/python_java:v1

MAINTAINER FedorD fedord.qa@gmail.com

# Set env variable and workdir
ENV PYTHON_TESTS_PATH /python-test

# Create folder for reports
RUN mkdir /reports

WORKDIR $PYTHON_TESTS_PATH

# Copy project files to container
COPY . .

# Install python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Run pytest and generate report
# Always return exit code as 0 to avoid container build interruption
RUN pytest -v --junitxml=/reports/python_tests_result.xml; exit 0

# Run main method of CreateAJarFile class
# And put output to test_jar_output.log file
RUN java -cp /python-test/jars/test.jar CreateAJarFile > /reports/test_jar_output.log

# Keep container alive after tests
CMD tail -f /dev/null
