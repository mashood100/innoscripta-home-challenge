import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hallo Welt';

  @override
  String welcome(String appName) {
    return 'Willkommen bei $appName';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Artikel',
      one: '1 Artikel',
      zero: 'Keine Artikel',
    );
    return '$_temp0';
  }

  @override
  String get projectScreenTitle => 'Projekt';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteProject => 'Projekt löschen';

  @override
  String get deleteProjectConfirmation => 'Sind Sie sicher, dass Sie dieses Projekt löschen möchten?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get untitledProject => 'Unbenanntes Projekt';

  @override
  String get tapToViewTasks => 'Tippen Sie hier, um Aufgaben in diesem Projekt anzuzeigen';

  @override
  String get giveProjectName => 'Geben Sie Ihrem Projekt einen Namen:';

  @override
  String get pleaseEnterTitle => 'Bitte geben Sie einen Titel ein';

  @override
  String get noProjectsFound => 'Keine Projekte gefunden';

  @override
  String get createProjectToStart => 'Erstellen Sie ein neues Projekt, um zu beginnen';

  @override
  String get projectTitle => 'Projekttitel';

  @override
  String get enterProjectName => 'Projektname eingeben';

  @override
  String get projectPreviewLabel => 'So wird es aussehen:';

  @override
  String get editProject => 'Projekt bearbeiten';

  @override
  String get createNewProject => 'Neues Projekt erstellen';

  @override
  String get updateProject => 'Projekt aktualisieren';

  @override
  String get createProject => 'Projekt erstellen';

  @override
  String get favoriteProjects => 'Lieblingsprojekte';

  @override
  String get noFavoriteProjects => 'Noch keine Lieblingsprojekte';

  @override
  String get createNewProjectTooltip => 'Neues Projekt erstellen';

  @override
  String get createNewTask => 'Neue Aufgabe erstellen';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get taskTitle => 'Aufgabentitel';

  @override
  String get enterTaskTitle => 'Aufgabentitel eingeben';

  @override
  String get description => 'Beschreibung';

  @override
  String get enterTaskDescription => 'Aufgabenbeschreibung eingeben';

  @override
  String get priority => 'Priorität';

  @override
  String get normal => 'Normal';

  @override
  String get medium => 'Mittel';

  @override
  String get high => 'Hoch';

  @override
  String get urgent => 'Dringend';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get selectDueDate => 'Fälligkeitsdatum auswählen';

  @override
  String get status => 'Status:';

  @override
  String get createTask => 'Aufgabe erstellen';

  @override
  String get updateTask => 'Aufgabe aktualisieren';

  @override
  String get deleteTask => 'Aufgabe löschen';

  @override
  String get deleteTaskConfirmation => 'Sind Sie sicher, dass Sie diese Aufgabe löschen möchten?';

  @override
  String get noTodoTasks => 'Keine Todo-Aufgaben';

  @override
  String get noInProgressTasks => 'Keine laufenden Aufgaben';

  @override
  String get noCompletedTasks => 'Keine abgeschlossenen Aufgaben';

  @override
  String get resetTimer => 'Timer zurücksetzen';

  @override
  String get resetTimerConfirmation => 'Sind Sie sicher, dass Sie den Timer zurücksetzen möchten? Sie verlieren Ihren Fortschritt.';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get untitledTask => 'Unbenannte Aufgabe';

  @override
  String get taskDetails => 'Aufgabendetails';

  @override
  String get taskId => 'Aufgaben-ID';

  @override
  String get created => 'Erstellt';

  @override
  String get timeSpent => 'Zeitaufwand';

  @override
  String get timer => 'Timer';

  @override
  String get comments => 'Kommentare';

  @override
  String get viewComments => 'Kommentare anzeigen';

  @override
  String get addComment => 'Kommentar hinzufügen...';

  @override
  String get updateComment => 'Kommentar aktualisieren';

  @override
  String get editComment => 'Kommentar bearbeiten';

  @override
  String get deleteComment => 'Kommentar löschen';

  @override
  String get deleteCommentConfirmation => 'Sind Sie sicher, dass Sie diesen Kommentar löschen möchten?';

  @override
  String get noComments => 'Noch keine Kommentare';

  @override
  String get commentUpdated => 'Kommentar erfolgreich aktualisiert';

  @override
  String get commentDeleted => 'Kommentar erfolgreich gelöscht';

  @override
  String get commentAdded => 'Kommentar erfolgreich hinzugefügt';
}
