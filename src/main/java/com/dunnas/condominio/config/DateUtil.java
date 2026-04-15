package com.dunnas.condominio.config;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component("dateUtil")
public class DateUtil {
    private static final DateTimeFormatter SHORT = DateTimeFormatter.ofPattern("dd/MM/yy HH:mm");
    private static final DateTimeFormatter LONG  = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    public String format(LocalDateTime d)     { return d != null ? d.format(SHORT) : "—"; }
    public String formatLong(LocalDateTime d) { return d != null ? d.format(LONG)  : "—"; }
}
