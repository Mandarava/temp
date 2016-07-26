package com.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import java.io.IOException;
import java.util.concurrent.TimeoutException;
import net.rubyeye.xmemcached.MemcachedClient;
import net.rubyeye.xmemcached.MemcachedClientBuilder;
import net.rubyeye.xmemcached.XMemcachedClientBuilder;
import net.rubyeye.xmemcached.command.BinaryCommandFactory;
import net.rubyeye.xmemcached.exception.MemcachedException;
import net.rubyeye.xmemcached.impl.KetamaMemcachedSessionLocator;
import net.rubyeye.xmemcached.transcoders.SerializingTranscoder;
import net.rubyeye.xmemcached.utils.AddrUtil;
import org.junit.Test;


public class TestXMemcached2 {
    @Test
    public void test()
        throws IOException, TimeoutException, InterruptedException,
        MemcachedException {
        MemcachedClientBuilder builder =
                new XMemcachedClientBuilder(
                        AddrUtil.getAddresses("localhost:11211"));

        // 设置连接池大小，即客户端个数
        builder.setConnectionPoolSize(5);
        // 宕机报警
        builder.setFailureMode(true);
        // 使用二进制文件
        builder.setCommandFactory(new BinaryCommandFactory());
        // 使用一致性哈希算法（Consistent Hash Strategy）
        builder.setSessionLocator(new KetamaMemcachedSessionLocator());
        // 使用序列化传输编码
        builder.setTranscoder(new SerializingTranscoder());
        // 进行数据压缩，大于1KB时进行压缩
        builder.getTranscoder().setCompressionThreshold(1024);
        builder.setConnectTimeout(300000);
        MemcachedClient memcachedClient = null;
        memcachedClient = builder.build();
        try {
            // 设置/获取
            memcachedClient.set("test", 0, "test");
            assertEquals("test", memcachedClient.get("test"));
            // 替换
            memcachedClient.replace("test", 0, "replace");
            assertEquals("replace", memcachedClient.get("test"));
            // 移除
            memcachedClient.delete("test");
            assertNull(memcachedClient.get("test"));
        }
        finally {
            if (memcachedClient != null) {
                try {
                    memcachedClient.shutdown();
                }
                catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }
}
