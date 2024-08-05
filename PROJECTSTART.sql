CREATE OR REPLACE PACKAGE VEHICLE_INFO_SEARCH      /*package containing procedure to view vehicles details and function to validate user login credentials*/
AS
TYPE R_VEHI_RECORD IS RECORD                     /*record of vehicle details*/
      (
          V_Vehiclereg_id VEHICLE_DETAILS.Vehiclereg_id%TYPE,
          V_Vehicle_owner VEHICLE_DETAILS.Vehicle_owner%TYPE,
          V_Vehicle_name VEHICLE_DETAILS.Vehicle_name%TYPE,
          V_Vehicle_model VEHICLE_DETAILS.Vehicle_model%TYPE,
          V_Fuel_norms VEHICLE_DETAILS.Fuel_norms%TYPE,
          V_Rc_number VEHICLE_DETAILS.Rc_number%TYPE,
          V_Emission_upto_date VEHICLE_DETAILS.Emission_upto_date%TYPE,
          V_Insurance_upto_date VEHICLE_DETAILS.Insurance_upto_date%TYPE);
PROCEDURE VEHICLE_SEARCH_BYVEHICLEREGID(P_VEHICLEREGID VEHICLE_DETAILS.Vehiclereg_id %TYPE,REF_VEHI_RECORD OUT SYS_REFCURSOR);
FUNCTION USER_LOGIN_VALIDATION(V_Vehicleregid2 USERLOGIN_DETAILS.Vehiclereg_id%TYPE,V_Vehicleregno USERLOGIN_DETAILS.Vehiclereg_number%TYPE,V_userpassword USERLOGIN_DETAILS.User_password%TYPE) RETURN BOOLEAN;

END VEHICLE_INFO_SEARCH;




CREATE OR REPLACE PACKAGE BODY VEHICLE_INFO_SEARCH    /*package body implementing procedures and functions declared in package declaration*/
AS
PROCEDURE VEHICLE_SEARCH_BYVEHICLEREGID(P_VEHICLEREGID VEHICLE_DETAILS.Vehiclereg_id %TYPE,REF_VEHI_RECORD OUT SYS_REFCURSOR)      /*procedure to search vehicle details based on vehicle registration id*/
IS
BEGIN
OPEN REF_VEHI_RECORD FOR SELECT Vehiclereg_id,Vehicle_owner,Vehicle_name,Vehicle_model,Fuel_norms,Rc_number,Emission_upto_date,Insurance_upto_date FROM VEHICLE_DETAILS WHERE Vehiclereg_id=P_VEHICLEREGID;
END VEHICLE_SEARCH_BYVEHICLEREGID;

FUNCTION USER_LOGIN_VALIDATION(V_Vehicleregid2 USERLOGIN_DETAILS.Vehiclereg_id%TYPE,V_Vehicleregno USERLOGIN_DETAILS.Vehiclereg_number%TYPE,V_userpassword USERLOGIN_DETAILS.User_password%TYPE) RETURN BOOLEAN
IS
V_RESULT BOOLEAN;
V_USERID USERLOGIN_DETAILS.Vehiclereg_number%TYPE;
V_USERPASSWORD1 USERLOGIN_DETAILS.User_password%TYPE; 
BEGIN
SELECT Vehiclereg_number,User_password INTO V_USERID,V_USERPASSWORD1 FROM USERLOGIN_DETAILS WHERE Vehiclereg_id=V_Vehicleregid2;
IF SQL%FOUND THEN
IF V_Vehicleregno=V_USERID AND V_userpassword=V_USERPASSWORD1 THEN    /*checking userid and password entered by user with the user id and password stored in the database*/
V_RESULT:=TRUE;
RETURN V_RESULT;
DBMS_OUTPUT.PUT_LINE('USER LOGIN CREDENTIAL VALID');
ELSE
V_RESULT:=FALSE;
RETURN V_RESULT;
DBMS_OUTPUT.PUT_LINE('USER LOGIN CREDENTIAL IS INVALID');
END IF;
ELSE
DBMS_OUTPUT.PUT_LINE('USER ID AND PASSWORD NOT FOUND');
END IF;
END USER_LOGIN_VALIDATION;  


END VEHICLE_INFO_SEARCH;
  
 
   