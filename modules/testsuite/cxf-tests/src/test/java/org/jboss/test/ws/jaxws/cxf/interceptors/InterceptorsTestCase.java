/*
 * JBoss, Home of Professional Open Source.
 * Copyright 2014, Red Hat Middleware LLC, and individual contributors
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
package org.jboss.test.ws.jaxws.cxf.interceptors;

import java.io.File;
import java.net.URL;
import java.util.LinkedList;
import java.util.List;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;

import junit.framework.Test;

import org.jboss.shrinkwrap.api.asset.StringAsset;
import org.jboss.wsf.test.JBossWSCXFTestSetup;
import org.jboss.wsf.test.JBossWSTest;
import org.jboss.wsf.test.JBossWSTestHelper;
import org.jboss.wsf.test.JBossWSTestHelper.BaseDeployment;

/**
 * Testcase for:
 * [JBWS-3837] Apache CXF interceptors setup through properties
 * [JBWS-3840] jboss-webservices.xml support for Apache CXF interceptor properties  
 *
 * @author alessio.soldano@jboss.com
 * @since 10-Oct-2014
 */
public class InterceptorsTestCase extends JBossWSTest
{
   public static BaseDeployment<?>[] createDeployments() {
      List<BaseDeployment<?>> list = new LinkedList<BaseDeployment<?>>();
      list.add(new JBossWSTestHelper.WarDeployment("jaxws-cxf-interceptors.war") { {
         archive
               .setManifest(new StringAsset("Manifest-Version: 1.0\n"
                     + "Dependencies: org.apache.cxf\n"))
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.EndpointImpl.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.AnotherEndpointImpl.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.BusInterceptor.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.BusCounterInterceptor.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.DeclaredInterceptor.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.EndpointInterceptor.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.EndpointCounterInterceptor.class)
               .addClass(org.jboss.test.ws.jaxws.cxf.interceptors.Counter.class)
               .addAsWebInfResource(new File(JBossWSTestHelper.getTestResourcesDir() + "/jaxws/cxf/interceptors/WEB-INF/jboss-webservices.xml"), "jboss-webservices.xml")
               .addAsResource(new File(JBossWSTestHelper.getTestResourcesDir() + "/jaxws/cxf/interceptors/WEB-INF/jaxws-endpoint-config.xml"));
         }
      });
      return list.toArray(new BaseDeployment<?>[list.size()]);
   }

   public static Test suite()
   {
      return new JBossWSCXFTestSetup(InterceptorsTestCase.class, JBossWSTestHelper.writeToFile(createDeployments()));
   }
   
   public void testEndpointWithBothBusAndEndpointInterceptors() throws Exception {
      URL wsdlURL = new URL("http://" + getServerHost() + ":8080/jaxws-cxf-interceptors/MyService" + "?wsdl");
      Service service = Service.create(wsdlURL, new QName("http://org.jboss.ws.jaxws.cxf/interceptors", "MyService"));
      Endpoint port = service.getPort(new QName("http://org.jboss.ws.jaxws.cxf/interceptors", "MyEndpointPort"), Endpoint.class);
      assertEquals("Hi FooBar! 0", port.echo("Hi"));
      assertEquals("Hi FooBar! 2", port.echo("Hi"));
      assertEquals("Hi FooBar! 4", port.echo("Hi"));
      assertEquals("Hi FooBar! 6", port.echo("Hi"));
   }
   
   public void testEndpointWithBusInterceptorsOnly() throws Exception {
      URL wsdlURL = new URL("http://" + getServerHost() + ":8080/jaxws-cxf-interceptors/AnotherService" + "?wsdl");
      Service service = Service.create(wsdlURL, new QName("http://org.jboss.ws.jaxws.cxf/interceptors", "AnotherService"));
      AnotherEndpoint port = service.getPort(new QName("http://org.jboss.ws.jaxws.cxf/interceptors", "AnotherEndpointPort"), AnotherEndpoint.class);
      assertEquals("Hi.Foo!.0", port.echo("Hi"));
      assertEquals("Hi.Foo!.1", port.echo("Hi"));
      assertEquals("Hi.Foo!.2", port.echo("Hi"));
      assertEquals("Hi.Foo!.3", port.echo("Hi"));
   }
   
}
