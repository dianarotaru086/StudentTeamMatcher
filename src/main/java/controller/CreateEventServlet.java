package controller;

import dao.CalendarDAO;
import model.CalendarEvent;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/createEvent")
public class CreateEventServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        String title =
                request.getParameter(
                        "title"
                );

        String description =
                request.getParameter(
                        "description"
                );

        String eventDate =
                request.getParameter(
                        "eventDate"
                );

        CalendarEvent event =
                new CalendarEvent();

        event.setUserId(
                user.getId()
        );

        event.setTitle(title);

        event.setDescription(
                description
        );

        event.setEventDate(
                eventDate
        );

        CalendarDAO calendarDAO =
                new CalendarDAO();

        calendarDAO.createEvent(
                event
        );

        response.sendRedirect(
                "schedule.jsp"
        );
    }
}