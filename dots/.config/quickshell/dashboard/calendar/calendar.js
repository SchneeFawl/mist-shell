function getDaysForGrid(year, month) {
    var days = [];

    // weekday of 1st of the month
    var startDayOfWeek = new Date(year, month, 1).getDay();

    // total days
    var totalDays = new Date(year, month + 1, 0).getDate();

    // totals days in prev month
    var prevMonthTotalDays = new Date(year, month, 0).getDate();

    // add padding days from prev month
    for (var i = startDayOfWeek - 1; i >= 0; i--) {
        days.push({
            day: prevMonthTotalDays - i,
            isCurrentMonth: false
        });
    }

    // add current month days
    for (var j = 1; j <= totalDays; j++) {
        days.push({
            day: j,
            isCurrentMonth: true
        })
    }

    // add padding days from next month to complete the 6x7 cell grid
    var nextMonthDays = 42 - days.length;
    for (var k = 1; k <= nextMonthDays; k++) {
        days.push({
            day: k,
            isCurrentMonth: false
        })
    }

    return days;
}
