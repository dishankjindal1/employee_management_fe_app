import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatetimeField extends StatefulWidget {
  final ValueNotifier<DateTime?> startDate;
  final ValueNotifier<DateTime?> endDate;
  final String? Function(String?)? toValidator;
  final String? Function(String?)? fromValidator;

  const CustomDatetimeField({
    required this.startDate,
    required this.endDate,
    required String? Function(String?)? validator,
    super.key,
  })  : toValidator = validator,
        fromValidator = validator;

  @override
  State<CustomDatetimeField> createState() => _CustomDatetimeFieldState();
}

class _CustomDatetimeFieldState extends State<CustomDatetimeField> {
  late final TextEditingController _startCtrl;
  late final TextEditingController _endCtrl;

  @override
  void initState() {
    super.initState();
    _startCtrl = TextEditingController();
    _endCtrl = TextEditingController();
    widget.endDate.addListener(() {
      _endCtrl.text = widget.endDate.value != null
          ? DateFormat('dd MMM yyyy').format(widget.endDate.value!)
          : '';
    });
    widget.startDate.addListener(() {
      _startCtrl.text = widget.startDate.value != null
          ? DateFormat('dd MMM yyyy').format(widget.startDate.value!)
          : '';
    });
  }

  @override
  void dispose() {
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) {
            return MyCalendarWidget(
              endDate: widget.endDate,
              startDate: widget.startDate,
            );
          }),
      child: Row(
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([_startCtrl, widget.startDate]),
              builder: (context, _) {
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minLeadingWidth: 0,
                  leading: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: TextFormField(
                    readOnly: true,
                    controller: _startCtrl,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'No date',
                    ),
                    validator: widget.toValidator,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            AntDesign.arrowright,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([_endCtrl, widget.endDate]),
              builder: (context, _) {
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minLeadingWidth: 0,
                  leading: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: TextFormField(
                    readOnly: true,
                    controller: _endCtrl,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'No date',
                    ),
                    validator: widget.fromValidator,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyCalendarWidget extends StatelessWidget {
  final ValueNotifier<DateTime?> endDate;
  final ValueNotifier<DateTime?> startDate;
  const MyCalendarWidget({
    required this.endDate,
    required this.startDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ListenableBuilder(
        listenable: Listenable.merge([startDate, endDate]),
        builder: (context, _) {
          final int? dateIndex;

          if (startDate.value != null && endDate.value != null) {
            final days = Moment.fromMicrosecondsSinceEpoch(
                    endDate.value!.microsecondsSinceEpoch)
                .difference(startDate.value!)
                .abs()
                .inDays;

            dateIndex = switch (days) {
              1 => 1,
              6 => 2,
              29 || 30 => 3,
              365 => 4,
              _ => null,
            };
          } else {
            dateIndex = null;
          }
          return Material(
            type: MaterialType.transparency,
            child: Align(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  startDate.value =
                                      DateUtils.dateOnly(DateTime.now());
                                  endDate.value =
                                      DateUtils.dateOnly(DateTime.now())
                                          .add(const Duration(days: 1));
                                },
                                style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      (dateIndex != null && dateIndex == 1)
                                          ? null
                                          : MaterialStatePropertyAll(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(24),
                                            ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Tomorrow',
                                  style: (dateIndex != null && dateIndex == 1)
                                      ? null
                                      : DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                ),
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  startDate.value =
                                      DateUtils.dateOnly(DateTime.now());
                                  endDate.value =
                                      DateUtils.dateOnly(DateTime.now())
                                          .add(const Duration(days: 6));
                                },
                                style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      (dateIndex != null && dateIndex == 2)
                                          ? null
                                          : MaterialStatePropertyAll(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(24),
                                            ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                child: Text(
                                  'After 1 Week',
                                  style: (dateIndex != null && dateIndex == 2)
                                      ? null
                                      : DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      startDate.value =
                                          DateUtils.dateOnly(DateTime.now());
                                      endDate.value = DateUtils.dateOnly(
                                              DateUtils.addMonthsToMonthDate(
                                                  startDate.value!, 1))
                                          .add(Duration(
                                              days: startDate.value!.day - 2));
                                    },
                                    style: ButtonStyle(
                                      elevation:
                                          const MaterialStatePropertyAll(0),
                                      backgroundColor:
                                          (dateIndex != null && dateIndex == 3)
                                              ? null
                                              : MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withAlpha(24),
                                                ),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                    ),
                                    child: Text(
                                      'After 1 Month',
                                      style:
                                          (dateIndex != null && dateIndex == 3)
                                              ? null
                                              : DefaultTextStyle.of(context)
                                                  .style
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                    )),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  startDate.value =
                                      DateUtils.dateOnly(DateTime.now());
                                  endDate.value = DateUtils.dateOnly(
                                          DateUtils.addMonthsToMonthDate(
                                              startDate.value!, 12))
                                      .add(Duration(
                                          days: startDate.value!.day - 2));
                                },
                                style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      (dateIndex != null && dateIndex == 4)
                                          ? null
                                          : MaterialStatePropertyAll(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withAlpha(24),
                                            ),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                child: Text(
                                  'After 1 Year',
                                  style: (dateIndex != null && dateIndex == 4)
                                      ? null
                                      : DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TableCalendar(
                        focusedDay:
                            DateUtils.dateOnly(endDate.value ?? DateTime.now()),
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        currentDay: DateUtils.dateOnly(DateTime.now()),
                        rangeStartDay: startDate.value,
                        rangeEndDay: endDate.value,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronPadding: EdgeInsets.only(left: 48),
                          rightChevronPadding: EdgeInsets.only(right: 48),
                          headerMargin: EdgeInsets.only(bottom: 16),
                        ),
                        rowHeight: 32,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          cellMargin: const EdgeInsets.all(6),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          todayTextStyle: DefaultTextStyle.of(context)
                              .style
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          startDate.value = selectedDay;
                        },
                        rangeSelectionMode: RangeSelectionMode.enforced,
                        onRangeSelected: (start, end, focusedDay) {
                          startDate.value = start;
                          endDate.value = end;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(width: 12),
                          Icon(
                            MaterialCommunityIcons.calendar_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          if (startDate.value == null)
                            const Text('No date')
                          else if (endDate.value != null)
                            Text(DateFormat('dd MMM, yyyy')
                                .format(endDate.value!))
                          else if (startDate.value != null)
                            Text(DateFormat('dd MMM, yyyy')
                                .format(startDate.value!)),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              startDate.value = null;
                              endDate.value = null;
                              context.pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              'Save',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                          // const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
