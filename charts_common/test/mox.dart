import 'package:mockito/annotations.dart';
import 'package:nimble_charts_common/common.dart';

@GenerateNiceMocks([
  MockSpec<ChartContext>(),
  MockSpec<GraphicsFactory>(),
  MockSpec<TextElement>(),
  MockSpec<TickFormatter<num>>(as: #MockNumericTickFormatter),
  MockSpec<BaseTickDrawStrategy>(as: #MockDrawStrategy),
])
void main() {}
