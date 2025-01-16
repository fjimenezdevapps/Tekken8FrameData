import 'package:flutter/material.dart';

class CellTapDetails {
  final int rowIndex;
  final int colIndex;

  CellTapDetails(this.rowIndex, this.colIndex);
}

// CustomDataTable con el soporte de onCellTap
class CustomDataTable<T> extends StatelessWidget {
  final List<String> headers;
  final List<List<T>> rowsCells;
  final double cellWidth;
  final double cellHeight;
  final double cellMargin;
  final double cellSpacing;
  final Color borderColor;
  final Function(CellTapDetails)
      onCellTap; // Callback para el toque en la celda

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.rowsCells,
    required this.onCellTap, // Requerimos este parámetro
    this.cellHeight = 70.0,
    this.cellWidth = 145.0,
    this.cellMargin = 10.0,
    this.cellSpacing = 10.0,
    required this.borderColor,
  });

  Widget _buildChild(double width, dynamic data, CellTapDetails details) =>
      GestureDetector(
        onTap: () =>
            onCellTap(details), // Llamamos al callback cuando se toca la celda
        child: SizedBox(
          width: width,
          child: Text(
            '$data',
            textAlign: TextAlign.center,
          ),
        ),
      );

  TableBorder _buildBorder({bool verticalInside = false}) {
    return TableBorder(
      top: BorderSide(color: borderColor),
      bottom: BorderSide(color: borderColor),
      left: BorderSide(color: borderColor),
      right: BorderSide(color: borderColor),
      verticalInside:
          verticalInside ? BorderSide(color: borderColor) : BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: cellWidth * headers.length + (cellMargin * 7),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            DataTable(
              border: _buildBorder(verticalInside: true),
              horizontalMargin: cellMargin,
              columnSpacing: cellSpacing,
              headingRowHeight: cellHeight,
              dataRowMinHeight: cellHeight,
              dataRowMaxHeight: cellHeight,
              columns: headers
                  .map((header) => DataColumn(
                      label:
                          _buildChild(cellWidth, header, CellTapDetails(0, 0))))
                  .toList(),
              rows: const [],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: DataTable(
                  border: _buildBorder(verticalInside: true),
                  horizontalMargin: cellMargin,
                  columnSpacing: cellSpacing,
                  headingRowHeight: 0,
                  dataRowMinHeight: cellHeight,
                  dataRowMaxHeight: cellHeight,
                  columns: headers
                      .map((header) =>
                          DataColumn(label: SizedBox(width: cellWidth)))
                      .toList(),
                  rows: rowsCells
                      .asMap()
                      .map((rowIndex, row) => MapEntry(
                          rowIndex,
                          DataRow(
                            cells: row
                                .asMap()
                                .map((colIndex, cell) => MapEntry(
                                      colIndex,
                                      DataCell(
                                        _buildChild(cellWidth, cell,
                                            CellTapDetails(rowIndex, colIndex)),
                                      ),
                                    ))
                                .values
                                .toList(),
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
