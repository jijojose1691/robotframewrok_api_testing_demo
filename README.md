## Test Plan

The test plan can be found within the TestPlan folder, labeled as "Products_and_Cart_Management_Test_Plan.pdf."


## Running the Tests

### Prerequisites

To run the tests written in RobotFramework, follow these steps to set up the test environment:

1. **Install Python:**
   Ensure Python 3.12+ is installed on your machine. If you don't have Python installed, download and install it from the official Python website (https://www.python.org/downloads/).
2. Execute docker image and make dure the APIs are available

### Run the Tests

1. **Clone the Repository:**
   Clone the test automation repository to your local machine using Git. 
   ```

2. **Install Dependencies:**
   Navigate to the root directory of the cloned repository and install the required dependencies using pip and the `requirements.txt` file. Run the following command:
   ```
   cd picnic-qa-jijojose1691
   pip install -r requirements.txt
   ```

3. **Execute Tests:**
   Execute the automated test scripts by running following commands
   ```
   robot --pythonpath Libraries --outputdir Reports Tests

   ```
   Please note that if the application is hosted on a server with a different IP address and port than localhost, you can specify these details as arguments.
   ```
   robot --pythonpath Libraries --outputdir Reports --variable HOST_IP:<SERVER_IP> --variable HOST_PORT:<SERVER_PORT>  Tests
   
   ```
   For eg:
   ```
   robot --pythonpath Libraries --outputdir Reports --variable HOST_IP:localhost --variable HOST_PORT:80  Tests
   
   ```

### Test Reports

* The reports can be found in Reports directory. A sample screenshot is attached below:

![TestResport-Image](/screenshots/test_report.PNG "test-report")
