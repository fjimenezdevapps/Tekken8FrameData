import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';

class FrameDataSource extends DataGridSource {
  FrameDataSource({required List<FramesNormal> frameMoves}) {
    _originalFrameMoves = frameMoves;
    updateData(frameMoves);
  }

  late List<FramesNormal> _originalFrameMoves;
  List<DataGridRow> dataGridRows = [];

  /// Actualiza los datos mostrados en el DataGrid.
  void updateData(List<FramesNormal> frameMoves) {
    dataGridRows = frameMoves
        .map<DataGridRow>(
          (frameMove) => DataGridRow(cells: [
            DataGridCell<String>(columnName: 'name', value: frameMove.name),
            DataGridCell<String>(
                columnName: 'command', value: frameMove.command),
            DataGridCell<String>(
                columnName: 'startup', value: frameMove.startup),
            DataGridCell<String>(columnName: 'block', value: frameMove.block),
            DataGridCell<String>(columnName: 'hit', value: frameMove.hit),
            DataGridCell<String>(
                columnName: 'properties', value: frameMove.hitLevel),
            DataGridCell<String>(columnName: 'damage', value: frameMove.damage),
          ]),
        )
        .toList();
    notifyListeners(); // Notifica al DataGrid para redibujar con los nuevos datos.
  }

  /// Filtra los datos basándose en una query.
  void filterData(String query) {
    final filteredData = _originalFrameMoves
        .where((frameMove) =>
            frameMove.name!.toLowerCase().contains(query.toLowerCase()) ||
            frameMove.command.toLowerCase().contains(query.toLowerCase()) ||
            frameMove.hitLevel.toLowerCase().contains(query.toLowerCase()) ||
            frameMove.damage.toLowerCase().contains(query.toLowerCase()))
        .toList();
    updateData(filteredData);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
