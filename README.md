# hospital_system

This is a hospital plus pharmacy management system.
The datebase is based on following questions:

The prescriptions-R-X chain of pharmacies has offered to give you a free lifetime supply of medicine if you design its database. Given the rising cost of health care, you agree. Here's the information that you gather: 
Patients are identified by an SSN, and their names, addresses, and ages must be recorded. Doctors are identified by an SSN. For each doctor, the name, speciality, and years of experience must be recorded. Each pharmaceutical company is identified by name and has a phone number. For each drug, the trade name and formula must be recorded. Each drug is sold by a given pharmaceutical company, and the trade name identifies a drug uniquely from among the products of that company. If a pharmaceutical company is deleted, you need not keep track of its products any longer. Each pharmacy has a name, address, and phone number. Every patient has a primary physician. Every doctor has at least one patient. Each pharmacy sells several drugs and has a price for each. A drug could be sold at several pharmacies, and the price could vary from one pharmacy to another. Doctors prescribe drugs for patients. A doctor could prescribe one or more drugs for several patients, and a patient could obtain prescriptions from several doctors. Each prescription has a date and a quantity associated with it. You can assume that, if a doctor prescribes the same drug for the same patient more than once, only the last such prescription needs to be stored. Pharmaceutical companies have long-term contracts with pharmacies. A pharmaceutical company can contract with several pharmacies, and a pharmacy can contract with several pharmaceutical companies. For each contract, you have to store a start date, an end date, and the text of the contract. Pharmacies appoint a supervisor for each contract. There must always be a supervisor for each contract, but the contract supervisor can change over the lifetime of the contract. 


## Getting Started

Steps to be followed:

1. Copy the hospital_MS_api folder from backend_api and paste it inside C:\xampp\htdocs
2. Open xampp and start apache and mySQL server.
3. Create a database named Hospital.
4. Import hospital.sql from database folder from here.
5. Run main.dart and it should start OR we could goto \hospital_management_system\build\windows\runner\Release and run hospital_system.exe

Some screenshots of the project
![image](https://user-images.githubusercontent.com/83692376/235198504-7cf68536-ac65-4f22-b90c-b8f34bb7f20c.png)
![image](https://user-images.githubusercontent.com/83692376/235198600-25e98909-23cd-4270-a668-6c82f329380f.png)
![image](https://user-images.githubusercontent.com/83692376/235198635-96fba751-2b33-47c5-83bb-ba0ae222cae5.png)
![image](https://user-images.githubusercontent.com/83692376/235198669-dd9d053d-201f-4128-8484-f49fc1adcac7.png)
![image](https://user-images.githubusercontent.com/83692376/235198738-dfbff401-393f-4c3a-ae02-dfe14c9fddaa.png)
![image](https://user-images.githubusercontent.com/83692376/235198797-276fa5f4-8978-4956-8c71-4be4c8af72d6.png)




