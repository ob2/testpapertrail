import ch.qos.logback.classic.encoder.PatternLayoutEncoder
import ch.qos.logback.classic.filter.LevelFilter
import ch.qos.logback.classic.filter.ThresholdFilter
import ch.qos.logback.core.ConsoleAppender
import ch.qos.logback.core.FileAppender
import ch.qos.logback.core.rolling.RollingFileAppender
import ch.qos.logback.core.rolling.TimeBasedRollingPolicy
import ch.qos.logback.core.spi.FilterReply
import ch.qos.logback.core.status.OnConsoleStatusListener
import gelf4j.logback.GelfAppender


import static ch.qos.logback.classic.Level.*;

conversionRule("eEx", com.egis.utils.LogbackExceptionLayout.class)

appender("STDOUT", ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        pattern = "%d{HH:mm:ss.SSS} %-5level %logger{0} [%X{user}%X{doc}:%X{ip}] %msg%n%eEx"
    }
}

appender("FILE", RollingFileAppender) {
    file = "logs/server.log"
    append = true
    rollingPolicy(TimeBasedRollingPolicy) {
        maxHistory = 2
        FileNamePattern = "logs/server-%d{yyyy-MM-dd}.log"
    }
    encoder(PatternLayoutEncoder) {
        pattern = "%d{HH:mm:ss.SSS} %level %logger{0} [%X{user}%X{doc}:%X{ip}] %msg%n%eEx"
    }
}

root(INFO, ["STDOUT", "FILE"])



logger("ch.qos", WARN)
logger("com.egis", INFO)
logger("com.egis.index.query", INFO)
logger("com.egis.kernel.messaging", INFO)
logger("com.egis.kernel.messaging.handlers.MatchingMessageHandler", INFO)
logger("com.egis.kernel.schedule", INFO)
logger("com.egis.conversion", INFO)
logger("com.egis.security", INFO)
logger("com.egis.importer", INFO)
logger("com.egis.notification", INFO)
logger("com.egis.monitoring", INFO)
logger("jdbc.sqlonly", INFO)
logger("jdbc.audit", WARN)
logger("jdbc.resultset", WARN)
logger("jdbc.connection", WARN)
logger("log4jdbc.debug", INFO)
logger("waffle", ERROR)
logger("httpclient.wire", ERROR)
logger("org.apache", WARN)
logger("org.hibernate", WARN)
logger("org.hibernate.cache", ERROR)
logger("org.jboss", WARN)
logger("freemarker", WARN)
logger("net.sf.ehcache", WARN)
logger("org.mortbay", WARN)
logger("org.opensaml", WARN)
logger("org.apache.pdfbox", ERROR)
logger("org.subethamail", WARN)
logger("org.apache.james.mime4j", ERROR)
logger("com.hazelcast", WARN)
logger("com.egis.SAMLService", INFO)

