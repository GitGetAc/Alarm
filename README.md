# Alarm

This is a desktop-based Alarm Clock application designed to allow users to set and manage alarms. It is developed using Object Pascal within the Lazarus Integrated Development Environment (IDE), leveraging its capabilities for rapid application development. The application features a graphical user interface (GUI) built with Lazarus Form files (.lfm) and is structured across several units, each serving distinct functionalities within the application.

### Main Components:
- **Unit1 (Main Form)**: Serves as the primary interface where users interact with the application. It displays the current time, date, and a list of alarms. Users can add or remove alarms through buttons, and the application supports showing the current time and date prominently. It also includes a digital clock display and an option to switch between a digital and analog clock view. Additionally, it features a tray icon for minimized operation and balloon hints for alarm notifications. The main form (`TForm1`) interacts with other units for adding alarms and displaying an analog clock.

### Functionalities:
- **Alarm Management**: Users can add and remove alarms. Alarms are listed in a `TListBox` component, allowing for easy management. When an alarm's time matches the current system time, a notification is displayed via a balloon hint and a message box.
- **Digital and Analog Clock Display**: The application can switch between showing the current time digitally and through an analog clock interface. The analog clock is drawn programmatically and updated every second to reflect real-time.
- **Tray Icon**: The application minimizes to the system tray and can be restored upon clicking the tray icon. Notifications for alarms are shown using balloon hints.
- **Persistence**: Alarms are saved to and loaded from a file named `alarmlist.dat`, ensuring persistence across sessions.

### Additional Units:
- **Unit2 (Form2)**: A secondary form (`TForm2`) used for adding new alarms. It provides a user-friendly interface for selecting hours and minutes for the alarm time and includes an optional hint text field. This form is modal, meaning it requires user interaction before returning to the main form.
- **Unit3 (Form3)**: Dedicated to drawing and updating an analog clock. It calculates and renders the positions of the hour, minute, and second hands based on the system time. The clock is drawn programmatically, including static elements like numbers and dynamic elements like the clock hands.

### Key Features:
- **Dynamic Time Display**: Both digital and analog clocks update every second to reflect real-time accurately.
- **Alarm Notifications**: When an alarm triggers, a balloon hint and a message box notify the user. Alarms are removed from the list after notification to prevent repeated alerts.
- **Customization**: Users can add alarms with optional hints for personal reminders.
- **Minimization**: The application can minimize to the system tray and be restored via the tray icon, enhancing usability without occupying desktop space.

### Technical Details:
- **Language and Frameworks**: Developed in Object Pascal using Lazarus IDE, which supports rapid application development with a visual interface builder.
- **File Structure**:
  - `.pas` files contain the logic and event handlers for forms.
  - `.lfm` files define the GUI layout and properties of forms.
  - Other resources like icons and executables support the application's operation and distribution.

### User Interaction:
- Users set alarms through a modal form that pops up upon clicking the "Add" button on the main form. They select the hour and minute for the alarm and optionally add a hint.
- Alarms are listed on the main interface and can be removed manually by the user.
- The application supports running in the background, notifying users through tray balloon hints when alarms trigger.

Overall, this application serves as a convenient tool for users needing reminders, blending aesthetic appeal with practicality through its digital and analog clock displays and straightforward alarm management features.
