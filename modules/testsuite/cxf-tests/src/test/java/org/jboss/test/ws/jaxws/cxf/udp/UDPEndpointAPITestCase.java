/*
 * JBoss, Home of Professional Open Source.
 * Copyright 2012, Red Hat Middleware LLC, and individual contributors
 * as indicated by the @author tags. See the copyright.txt file in the
 * distribution for a full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, write to the Free
 * Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA, or see the FSF site: http://www.fsf.org.
 */
package org.jboss.test.ws.jaxws.cxf.udp;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.ws.Endpoint;
import javax.xml.ws.Service;

import junit.framework.Test;

import org.apache.cxf.Bus;
import org.apache.cxf.BusFactory;
import org.jboss.wsf.test.JBossWSCXFTestSetup;
import org.jboss.wsf.test.JBossWSTest;

/**
 * Test case for publishing a UDP (SOAP-over-UDP 1.1) endpoint through API
 *
 * @author alessio.soldano@jboss.com
 * @since 6-May-2013
 */
public final class UDPEndpointAPITestCase extends JBossWSTest
{
   public static Test suite()
   {
      return new JBossWSCXFTestSetup(UDPEndpointAPITestCase.class, "jaxws-cxf-udp-api.war");
   }
   
   public void testServerSide() throws Exception
   {
      URL url = new URL("http://" + getServerHost() + ":8080/jaxws-cxf-udp-api");
      BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
      assertEquals("true", br.readLine());
   }
   
   public void testClientSide() throws Exception
   {
      Bus bus = BusFactory.newInstance().createBus();
      BusFactory.setThreadDefaultBus(bus);
      Object implementor = new HelloWorldImpl();
      Endpoint ep = Endpoint.publish("soap.udp://:9436", implementor);
      try
      {
         final QName serviceName = new QName("http://org.jboss.ws/jaxws/cxf/udp", "HelloWorldService");
         final QName udpPortName = new QName("http://org.jboss.ws/jaxws/cxf/udp", "UDPHelloWorldImplPort");
         Service service = Service.create(serviceName);
         service.addPort(udpPortName, "http://schemas.xmlsoap.org/soap/", "soap.udp://:9436");
         HelloWorld proxy = (HelloWorld) service.getPort(udpPortName, HelloWorld.class);
         assertEquals("Hi", proxy.echo("Hi"));
      }
      finally
      {
         ep.stop();
         bus.shutdown(true);
      }
   }
   
}