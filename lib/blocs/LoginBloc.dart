import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapp/WeatherModel.dart';
import 'package:flutterapp/WeatherRepo.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// first event fetchWeather event
class FetchWeatherEvent extends WeatherEvent {
  final _city;

  FetchWeatherEvent(this._city);

  @override
  List<Object> get props => [_city];
}

class ResetWeatherEvent extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo);

  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      print("object featchWeather ");
      yield WeatherIsLoading();
      try {
        WeatherModel weatherModel = await weatherRepo.getWeather(event._city);
        print("object WeatherIsLoaded ");
        yield WeatherIsLoaded(weatherModel);
      } catch (e) {
        print("object WeatherIsNotLoaded ");
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeatherEvent) {
      print("object ResetWeatherEvent ");
      yield WeatherIsNotSearched();
    }
  }
}
