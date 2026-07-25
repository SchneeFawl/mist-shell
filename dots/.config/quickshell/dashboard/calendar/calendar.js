function getDaysForGrid(year, month) {
    var days = [];

    var today = new Date();
    var tYear = today.getFullYear();
    var tMonth = today.getMonth();
    var tDate = today.getDate();

    var startDayOfWeek = new Date(year, month, 1).getDay();
    var totalDays = new Date(year, month + 1, 0).getDate();
    var prevMonthTotalDays = new Date(year, month, 0).getDate();

    // add padding days from prev month
    for (var i = startDayOfWeek - 1; i >= 0; i--) {
        days.push({
            day: prevMonthTotalDays - i,
            isCurrentMonth: false,
        });
    }

    // add current month days
    for (var j = 1; j <= totalDays; j++) {
        var checkToday = (year === tYear && month === tMonth && j === tDate);
        days.push({
            day: j,
            isCurrentMonth: true,
            isToday: checkToday
        })
    }

    // add padding days from next month to complete the 6x7 cell grid
    var nextMonthDays = 42 - days.length;
    for (var k = 1; k <= nextMonthDays; k++) {
        days.push({
            day: k,
            isCurrentMonth: false,
            isToday: false
        })
    }

    // 7 days in a row containing today
    for (var row = 0; row < 6; row++) {
        var weekHasToday = false;
        for (var col = 0; col < 7; col++) {
            if (days[row * 7 + col].isToday) {
                weekHasToday = true;
                break;
            }
        }
        for (var c = 0; c < 7; c++) {
            days[row * 7 + c].isCurrentWeek = weekHasToday;
        }
    }

    return days;
}
