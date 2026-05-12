package websocket;

import jakarta.websocket.server.ServerApplicationConfig;
import jakarta.websocket.server.ServerEndpointConfig;

import java.util.HashSet;
import java.util.Set;

public class WebSocketConfig
        implements ServerApplicationConfig {

    @Override
    public Set<ServerEndpointConfig> getEndpointConfigs(
            Set<Class<? extends jakarta.websocket.Endpoint>> endpointClasses){

        return new HashSet<>();
    }

    @Override
    public Set<Class<?>> getAnnotatedEndpointClasses(
            Set<Class<?>> scanned){

        Set<Class<?>> results =
                new HashSet<>();

        results.add(
                TeamChatEndpoint.class
        );
        results.add(
                FileSyncEndpoint.class
        );

        return results;
    }
}