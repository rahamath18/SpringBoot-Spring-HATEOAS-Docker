## Spring HATEOAS Example Development using SpringBoot 2.2.2, Hibernate 5.1.0, MySql 5.7.12, and Docker 19.03.8


### Used technology stack in this example

	1. Java 8
	2. Apache Maven 3.5.4
	3. SpringBoot 2.2.2
	4. Spring HATEOAS 1.0.2
	5. Hibernate Annotations 5.1.0
	6. Hibernate Core 5.4.9
	7. Hibernate Validator 6.0.18
	8. MySql 5.7.12
	9. Docker Version: 19.03.8 - https://hub.docker.com/editions/community/docker-ce-desktop-windows/
	10. Postman Version 7.14.0


### What is Spring HATEOAS?

	Spring Hypertext as the Engine of Application State - Spring HATEOAS.
	

### What is the Use Case of this example?

	The Use case of this example is 'Customer and his/her orders' application.

	
### Use following URL to create spring boot initial application structure

	https://start.spring.io/


### Maven initial setup

	$ mvn dependency:tree
	$ mvn eclipse:eclipse


### Build application jar or war

	$ mvn clean package
		

## Docker Deployment 

### MySQL Database Docker Container

	$ docker network create springboot-HATEOAS-mysqldb-network-1
	
	$ docker container run --name springboot-HATEOAS-host-mysqldb --network springboot-HATEOAS-mysqldb-network-1 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=order_system -d mysql
	
	$ Use this in application.properties 
		jdbc:mysql://springboot-HATEOAS-host-mysqldb:3306/order_system

	$ docker container logs -f springboot-HATEOAS-host-mysqldb

### Account Microservice Database Docker Container
	
	$ docker image build -t springboot-hateoas-image-1 .
	
	$ docker container run --network springboot-HATEOAS-mysqldb-network-1 --name springboot-hateoas-container-1 -p 8001:8001 -d springboot-hateoas-image-1
	
	$ docker container logs -f springboot-hateoas-container-1
	
	Browse	http://localhost:8001/springboot-HATEOAS-example


### Test Case 1: Add Customer URL in POSTMAN

	Request 1: http://localhost:8001/springboot-HATEOAS-example/customer/add-customer?customerName=rahamath18
	
	Request 2: http://localhost:8001/springboot-HATEOAS-example/customer/add-customer?customerName=rahamath19
	
	Request 3: http://localhost:8001/springboot-HATEOAS-example/customer/add-customer?customerName=rahamath20
	
	Request 4: http://localhost:8001/springboot-HATEOAS-example/customer/add-customer?customerName=rahamath21
	
	Response: {"message":"Customer is added successfully"}

	Error Messages
		1. Customer Details Are Empty
		2. Customer Name Length Min 8 and Max 20
		3. Customer already exists	
		4. ...
		5. ...
	
### Test Case 2: Get All Customers in POSTMAN

	Request: http://localhost:8001/springboot-HATEOAS-example/customer/customers
	
	Response: 

### Test Case 3: Get Customer by Customer ID

	Request: http://localhost:8001/springboot-HATEOAS-example/customer/1
	
	Response: 
	
### Test Case 4: Add Order URL in POSTMAN

	Request 1: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath18&totalPrice=111.11
	Request 2: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath18&totalPrice=222.22
	Request 3: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath18&totalPrice=333.333
	
	Request 1: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath19&totalPrice=444.44
	Request 2: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath19&totalPrice=555.55
	Request 3: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath19&totalPrice=666.66
	
	Request 1: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath20&totalPrice=777.77
	Request 2: http://localhost:8001/springboot-HATEOAS-example/order/add-order?customerName=rahamath20&totalPrice=888.88
	
	Response: {"message":"Customer is added successfully"}

### Error Messages
	1. Customer Details Are Empty
	2. Order Details Are Empty
	3. Customer Name Length Min 8 and Max 20
	4. Customer does not exists
	5. Order's Total Price Can Not Exceed 50000
	6. Order is added successfully	
	
### Test Case 5: Get All Customers in POSTMAN

	Request: http://localhost:8001/springboot-HATEOAS-example/order/orders
	
	Response: 

### Test Case 6: Get Customer by Customer ID

	Request: http://localhost:8001/springboot-HATEOAS-example/order/1
	
	Response: 

### Test Case 7: Get All Customer With HATEOAS Self Links 

	Request: http://localhost:8001/springboot-HATEOAS-example/proxy/customers
	
	Response:
	
### Test Case 8: Get All Orders With HATEOAS Self Links 

	Request: http://localhost:8001/springboot-HATEOAS-example/proxy/orders
	
	Response:
	
### Test Case 9: Get All Orders By Customer Id With HATEOAS Self Links 

	Request: http://localhost:8001/springboot-HATEOAS-example/proxy/orders-by-customer-id/1
	
	Response:
	
### Test Case 10: Get All Orders By Customer Name With HATEOAS Self Links 

	Request: http://localhost:8001/springboot-HATEOAS-example/proxy/orders-by-customer-name/rahamath18
	
	Response:
	
	
### Test Case 11: Get All Customers with His/Her Orders With HATEOAS Self Links 

	Request: http://localhost:8001/springboot-HATEOAS-example/proxy/customers-with-orders
	
	Response:


### Notes:

	If you use @RequestBody to accept the request parameters follow the below method signature.
		
	@RequestMapping(value = "/add-customer", method = RequestMethod.POST)
	public ResponseEntity<?> addCustomer(@RequestBody CustomerDto customer) {
		// ...
	}
	
For the above method signature, Spring RestTemplate and POSTMAN with application/json settings can be act as client
 
