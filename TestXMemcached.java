package com.test;

import static org.junit.Assert.assertEquals;
import java.util.concurrent.TimeoutException;
import net.rubyeye.xmemcached.MemcachedClient;
import net.rubyeye.xmemcached.exception.MemcachedException;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class TestXMemcached {

    private ApplicationContext app;

    private MemcachedClient memcachedClient;


    @Before
    public void init() {
        app =
                new ClassPathXmlApplicationContext(
                        "com/springContext.xml");
        memcachedClient = (MemcachedClient) app.getBean("memcachedClient");

    }


    @Test
    public void test() {
        try {
            memcachedClient.set("test", 0, "test");
            System.out.println(memcachedClient.get("test"));
            assertEquals("test", memcachedClient.get("test"));
        }
        catch (TimeoutException e) {
            e.printStackTrace();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        catch (MemcachedException e) {
            e.printStackTrace();
        }
    }
}
