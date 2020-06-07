FROM fedordqa/python_java:v1

MAINTAINER FedorD fedord.qa@gmail.com

# Set env variable and workdir
ENV PYTHON_TESTS_PATH /python-test
WORKDIR $PYTHON_TESTS_PATH

# Copy project files to container
COPY . .

# Install python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Run pytest and generate report
RUN ["pytest", "-v", "--junitxml=reports/result.xml"]

# Run main method of CreateAJarFile class
# And put output to test_jar_output.log file
RUN java -cp /python-test/jars/test.jar CreateAJarFile > test_jar_output.log

# Keep container alive after tests
CMD tail -f /dev/null
