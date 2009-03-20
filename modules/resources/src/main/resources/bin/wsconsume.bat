@echo off

@if not "%ECHO%" == ""  echo %ECHO%
@if "%OS%" == "Windows_NT"  setlocal

set DIRNAME=.\
if "%OS%" == "Windows_NT" set DIRNAME=%~dp0%
set PROGNAME=run.bat
if "%OS%" == "Windows_NT" set PROGNAME=%~nx0%

rem Read all command line arguments

REM
REM The %ARGS% env variable commented out in favor of using %* to include
REM all args in java command line. See bug #840239. [jpl]
REM
REM set ARGS=
REM :loop
REM if [%1] == [] goto endloop
REM         set ARGS=%ARGS% %1
REM         shift
REM         goto loop
REM :endloop

set JAVA=%JAVA_HOME%\bin\java
set JBOSS_HOME=%DIRNAME%\..
rem Setup the java endorsed dirs
set JBOSS_ENDORSED_DIRS=%JBOSS_HOME%\lib\endorsed

rem shared libs
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JAVA_HOME%/lib/tools.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/activation.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/getopt.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/wstx.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jbossall-client.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/log4j.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/mail.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jbossws-spi.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jbossws-common.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jbossws-framework.jar

rem shared jaxws libs
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxws-tools.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxws-rt.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/stax-api.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxb-api.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxb-impl.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxb-xjc.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/streambuffer.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/stax-ex.jar

rem stack specific libs
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jbossws-cxf-client.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/commons-collections.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/commons-lang.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-api.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-common-utilities.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-bindings-corba.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-bindings-http.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-bindings-object.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-bindings-soap.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-bindings-xml.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-core.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-management.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-transports-jms.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-transports-local.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-rt-transports-http.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-tools-common.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-tools-validator.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-tools-wsdlto-core.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-tools-wsdlto-databinding-jaxb.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-tools-wsdlto-frontend-jaxws.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-xjc-dv.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-xjc-ts.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/cxf-wstx-msv-validation.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/geronimo-ws-metadata_2.0_spec.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jaxws-api.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jboss-ejb3x.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/jboss-javaee.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/velocity.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/XmlSchema.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/xml-resolver.jar
set WSCONSUME_CLASSPATH=%WSCONSUME_CLASSPATH%;%JBOSS_HOME%/client/wsdl4j.jar

rem Execute the JVM
"%JAVA%" %JAVA_OPTS% -Djava.endorsed.dirs="%JBOSS_ENDORSED_DIRS%" -Dlog4j.configuration=wstools-log4j.xml -classpath "%WSCONSUME_CLASSPATH%" org.jboss.wsf.spi.tools.cmd.WSConsume %*
