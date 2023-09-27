import 'package:flood_mobile/Pages/torrent_screen/widgets/combined_filterAndSort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/sort_by_torrent_bloc/sort_by_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/filter_by_bottom_sheet.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/sort_by_bottom_sheet.dart';
import 'package:flood_mobile/l10n/l10n.dart';


class SearchTorrentTextField extends StatefulWidget {
  final int themeIndex;
  final FilterTorrentState stateFilterBlocState;
  final SortByTorrentState sortByState;
  SearchTorrentTextField({
    Key? key,
    required this.themeIndex,
    required this.stateFilterBlocState,
    required this.sortByState,
  }) : super(key: key);

  @override
  State<SearchTorrentTextField> createState() => _SearchTorrentTextFieldState();
}

class _SearchTorrentTextFieldState extends State<SearchTorrentTextField> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double wp = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: wp * 0.05, right: wp * 0.05),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        key: Key("Search Torrent TextField"),
                        onChanged: (value) {
                          BlocProvider.of<FilterTorrentBloc>(context)
                              .add(SetSearchKeywordEvent(
                            searchKeyword: value,
                          ));
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          hintText: context.l10n.search_torrent_text,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: wp*0.13,
                    height: wp*0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: (){
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: ThemeBloc.theme(widget.themeIndex)
                              .colorScheme
                              .background,
                          builder: (context) {
                            return CombinedBottomSheet(themeIndex: widget.themeIndex,);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (checkFilterStatus() || checkSortByStatus()),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextButton(
                            onPressed:  () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.1),
                              side: BorderSide(
                                width: 1.0,
                                color: Colors.green,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                returnFilterText(widget.stateFilterBlocState),
                                  style: TextStyle(
                                    color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: checkFilterStatus() ? () {
                                    setState(() {
                                      BlocProvider.of<
                                          FilterTorrentBloc>(
                                          context)
                                          .add(
                                        SetFilterSelectedEvent(
                                          filterStatus:
                                          FilterValue.all,
                                        ),
                                      );
                                    });
                                  } : () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: ThemeBloc.theme(widget.themeIndex)
                                          .colorScheme
                                          .background,
                                      builder: (context) {
                                        return CombinedBottomSheet(
                                          themeIndex: widget.themeIndex,
                                          defaultPage: 1,
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    checkFilterStatus() ? Icons.cancel_rounded : Icons.add_circle_rounded,
                                    size: 20,
                                    color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed:  () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            backgroundColor: Colors.white.withOpacity(0.1),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.green,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              returnSortByText(widget.sortByState)[0],
                                style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  var sortByTorrentBloc =
                                  BlocProvider.of<SortByTorrentBloc>(context, listen: false);
                                  setSortByDirection(sortByTorrentBloc, widget.sortByState);
                                },
                                child: Icon(
                                  returnSortByText(widget.sortByState)[1] != SortByDirection.ascending ?
                                      Icons.arrow_upward :
                                      Icons.arrow_downward,
                                  size: 20,
                                  color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),),),
            ),
          ],
        ),
      ),
    );
  }

  bool checkSortByStatus() => !(widget.sortByState.sortByStatus == SortByValue.name && widget.sortByState.nameDirection == SortByDirection.ascending);

  bool checkFilterStatus() => widget.stateFilterBlocState.filterStatus != FilterValue.all ;

}

void setSortByDirection(SortByTorrentBloc sortByTorrentBloc, SortByTorrentState sortByState) {
  final tagSelected = sortByState.sortByStatus;
  switch (tagSelected) {
    case SortByValue.name:
      sortByTorrentBloc.add(
        SetNameDirectionEvent(
          nameDirection: sortByState.nameDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.percentage:
      sortByTorrentBloc.add(
        SetPercentageDirectionEvent(
          percentageDirection: sortByState.percentageDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.downloaded:
      sortByTorrentBloc.add(
        SetDownloadedDirectionEvent(
          downloadedDirection: sortByState.downloadedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.downSpeed:
      sortByTorrentBloc.add(
        SetDownSpeedDirectionEvent(
          downSpeedDirection: sortByState.downSpeedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.uploaded:
      sortByTorrentBloc.add(
        SetUploadedDirectionEvent(
          uploadedDirection: sortByState.uploadedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.upSpeed:
      sortByTorrentBloc.add(
        SetUpSpeedDirectionEvent(
          upSpeedDirection: sortByState.upSpeedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.ratio:
      sortByTorrentBloc.add(
        SetRatioDirectionEvent(
          ratioDirection: sortByState.ratioDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.fileSize:
      sortByTorrentBloc.add(
        SetFileSizeDirectionEvent(
          fileSizeDirection: sortByState.fileSizeDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.peers:
      sortByTorrentBloc.add(
        SetPeersDirectionEvent(
          peersDirection: sortByState.peersDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.seeds:
      sortByTorrentBloc.add(
        SetSeedsDirectionEvent(
          seedsDirection: sortByState.seedsDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.dateAdded:
      sortByTorrentBloc.add(
        SetDateAddedDirectionEvent(
          dateAddedDirection: sortByState.dateAddedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;

    case SortByValue.dateCreated:
      sortByTorrentBloc.add(
        SetDateCreatedDirectionEvent(
          dateCreatedDirection: sortByState.dateCreatedDirection == SortByDirection.ascending
              ? SortByDirection.descending
              : SortByDirection.ascending,
        ),
      );
      break;
  }
}

List<dynamic> returnSortByText(SortByTorrentState sortByState) {
  final tagSelected = sortByState.sortByStatus;
  var sortByStatus = 'Name';
  var sortByDirection = SortByDirection.ascending;

  switch(tagSelected){
    case SortByValue.name:
      sortByStatus = "Name";
      sortByDirection = sortByState.nameDirection;
      break;
    case SortByValue.percentage:
      sortByStatus = "Percentage";
      sortByDirection = sortByState.percentageDirection;
      break;
    case SortByValue.downloaded:
      sortByStatus = "Downloaded";
      sortByDirection = sortByState.downloadedDirection;
      break;
    case SortByValue.downSpeed:
      sortByStatus = "Download Speed";
      sortByDirection = sortByState.downSpeedDirection;
      break;
    case SortByValue.uploaded:
      sortByStatus = "Uploaded";
      sortByDirection = sortByState.uploadedDirection;
      break;
    case SortByValue.upSpeed:
      sortByStatus = "Upload Speed";
      sortByDirection = sortByState.upSpeedDirection;
      break;
    case SortByValue.ratio:
      sortByStatus = "Ratio";
      sortByDirection = sortByState.ratioDirection;
      break;
    case SortByValue.fileSize:
      sortByStatus = "File Size";
      sortByDirection = sortByState.fileSizeDirection;
      break;
    case SortByValue.peers:
      sortByStatus = "Peers";
      sortByDirection = sortByState.peersDirection;
      break;
    case SortByValue.seeds:
      sortByStatus = "Seeds";
      sortByDirection = sortByState.seedsDirection;
      break;
    case SortByValue.dateAdded:
      sortByStatus = "Date Added";
      sortByDirection = sortByState.dateAddedDirection;
      break;
    case SortByValue.dateCreated:
      sortByStatus = "Date Created";
      sortByDirection = sortByState.dateCreatedDirection;
      break;
  }

  return [sortByStatus, sortByDirection, tagSelected];
}

String returnFilterText(FilterTorrentState stateFilterBlocState) {
  final tagSelected = stateFilterBlocState.tagSelected;
  final trackerURISelected = stateFilterBlocState.trackerURISelected;
  final filterStatus =
      stateFilterBlocState.filterStatus.toString().split(".").last;

  if (tagSelected == 'all' || tagSelected == 'null' || tagSelected == '') {
    if (trackerURISelected == 'all' ||
        trackerURISelected == 'null' ||
        trackerURISelected == '') {
      return filterStatus[0].toUpperCase() + filterStatus.substring(1);
    } else {
      return trackerURISelected;
    }
  } else {
    return tagSelected;
  }
}

