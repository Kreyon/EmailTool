var LastClickedsortby = "";
var LastClickedSortby_Text = "";

var _visiblePages = 5;
// COMPULSORY VARIABLES
var RecordShow = 10;
var PageClick = 1;

function PaginationVisiblePages(PageClick) {

    var divisions = Math.ceil(PageClick / _visiblePages);

    var startingPointers = [];

    for (var i = 0; i < divisions; i++) {
        startingPointers.push(i * _visiblePages);
    }

    var FromWhichPageShowStartNumber = startingPointers[startingPointers.length - 1];

    var NumberPlusOne = Number(FromWhichPageShowStartNumber) + 1;

    var selectElement = $("#DivPager li:nth-child(" + NumberPlusOne + ")");

    $('#DivPager .currentuse').each(function () {
        $(this).removeAttr("data-livalue");
        $(this).hide();
    });

    for (i = NumberPlusOne; i <= (Number(FromWhichPageShowStartNumber) + _visiblePages) ; i++) {
        selectElement.next().attr("data-livalue", i);
        selectElement.next().show();

        selectElement = $('#DivPager').find('.currentuse[data-livalue]').last();
    }
}

function GoToNextSegment() {

    var LastVisibleRow = $('#DivPager').find('.currentuse[data-livalue]').last().attr("data-livalue");

    if (LastVisibleRow !== undefined) {

        if (Number($('#DivPager').find(".currentuse").length) == Number(LastVisibleRow)) {
            return false;
        }

        var NumberPlusOne = (Number(LastVisibleRow) + 1);

        var selectElement = $('#DivPager').find('.currentuse[data-livalue]').last();

        $('#DivPager .currentuse').each(function () {
            $(this).removeAttr("data-livalue");
            $(this).hide();
        });

        for (i = NumberPlusOne; i <= (Number(LastVisibleRow) + _visiblePages) ; i++) {

            selectElement.next().attr("data-livalue", i);
            selectElement.next().show();

            selectElement = $('#DivPager').find('.currentuse[data-livalue]').last();
        }
    }
}

function GoToPrevSegment() {

    var LastVisibleRow = $('#DivPager').find('.currentuse[data-livalue]').first().attr("data-livalue");

    if (LastVisibleRow !== undefined) {

        if (Number(LastVisibleRow) == 1) {
            return false;
        }

        var selectElement = $('#DivPager').find('.currentuse[data-livalue]').first();

        $('#DivPager .currentuse').each(function () {
            $(this).removeAttr("data-livalue");
            $(this).hide();
        });

        for (i = (Number(LastVisibleRow) - 1) ; i >= (Number(LastVisibleRow) - _visiblePages) ; i--) {

            selectElement.prev().attr("data-livalue", i);
            selectElement.prev().show();

            selectElement = $('#DivPager').find('.currentuse[data-livalue]').first();
        }
    }
}

function fn_sortbynumber(that) {

    var selectedOption = $(that).val();

    //SET 
    RecordShow = selectedOption;

    // INITIAL SHOWING LOADER
    showGlobalLoader();

    window.setTimeout(function () {
        GetListing(1);
    }, 500);
}

function ListingRefreshMe() {
    // INITIAL SHOWING LOADER
    //showGlobalLoader();

    $("#txtsearch").val("");

    try {
        $("#_ddlSortByCurrency").val("All");
        $("#Hidstartdate").val("");
        $("#Hidenddate").val("");
        $('#reportrange span').html("Click here for date filter");
        $("#_AmountSum").hide(); $("#_AmountDebit").hide(); $("#_AmountCredit").hide();
    } catch (e) { }

    LastClickedsortby = "";
    LastClickedSortby_Text = "";

    try { ResetAdvancedFilter(); } catch (e) { }

    //window.setTimeout(function () {
    //    GetListing(1);
    //}, 1000);

}

// BACKUP
//PaginationString += "<li " + (PageClick == i ? "class='active'" : "") + " ><a href='javascript:;' Onclick='GetListing(" + i + ")'>" + i + " " + (PageClick == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
//PaginationString += "<li " + (PageClick == i ? "class='currentuse active'" : "class='currentuse'") + " " + (i <= _visiblePages ? "data-livalue=" + i + "" : "style='display:none;'") + "><a href='javascript:;' Onclick='GetListing(" + i + ");showGlobalLoader();'>" + i + " " + (PageClick == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
