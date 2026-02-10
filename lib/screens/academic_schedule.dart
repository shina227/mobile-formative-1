import 'package:flutter/material.dart';

class AcademicScheduleScreen extends StatefulWidget {
  const AcademicScheduleScreen({super.key});

  @override
  State<AcademicScheduleScreen> createState() => _AcademicScheduleScreenState();
}

class _AcademicScheduleScreenState extends State<AcademicScheduleScreen> {
  // Form state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
  final TextEditingController _locationController = TextEditingController();
  String _selectedSessionType = 'Class';

  // Session types
  final List<String> _sessionTypes = [
    'Class',
    'Mastery Session',
    'Study Group',
    'PLD Meeting',
  ];

  // Demo sessions data
  final List<Map<String, dynamic>> _sessions = [
    {
      'id': '1',
      'title': 'Mathematics for Machine Learning',
      'date': DateTime.now().add(const Duration(days: 1)),
      'startTime': TimeOfDay(hour: 10, minute: 0),
      'endTime': TimeOfDay(hour: 11, minute: 30),
      'location': 'Ethiopia',
      'type': 'Class',
      'attendance': true,
    },
    {
      'id': '2',
      'title': 'Moblie Development Study Group',
      'date': DateTime.now().add(const Duration(days: 2)),
      'startTime': TimeOfDay(hour: 14, minute: 0),
      'endTime': TimeOfDay(hour: 16, minute: 0),
      'location': 'Library',
      'type': 'Study Group',
      'attendance': false,
    },
    {
      'id': '3',
      'title': 'Foundations Mastery',
      'date': DateTime.now().add(const Duration(days: 3)),
      'startTime': TimeOfDay(hour: 13, minute: 0),
      'endTime': TimeOfDay(hour: 15, minute: 0),
      'location': 'Malawi',
      'type': 'Mastery Session',
      'attendance': true,
    },
  ];

  // Format date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Get color for session type
  Color _getSessionTypeColor(String type) {
    switch (type) {
      case 'Class':
        return const Color(0xFF4A6572);
      case 'Mastery Session':
        return const Color(0xFF0A2463);
      case 'Study Group':
        return const Color(0xFF344955);
      case 'PLD Meeting':
        return const Color(0xFF232F34);
      default:
        return Colors.white;
    }
  }

  // Get icon for session type
  IconData _getSessionTypeIcon(String type) {
    switch (type) {
      case 'Class':
        return Icons.school;
      case 'Mastery Session':
        return Icons.star;
      case 'Study Group':
        return Icons.group;
      case 'PSL Meeting':
        return Icons.meeting_room;
      default:
        return Icons.event;
    }
  }

  // Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF0A2463),
            colorScheme: const ColorScheme.light(primary: Color(0xFF0A2463)),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Start time picker
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF0A2463),
            colorScheme: const ColorScheme.light(primary: Color(0xFF0A2463)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  // End time picker
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF0A2463),
            colorScheme: const ColorScheme.light(primary: Color(0xFF0A2463)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  // Add new session
  void _addSession() {
    if (_formKey.currentState!.validate()) {
      final newSession = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': _titleController.text,
        'date': _selectedDate,
        'startTime': _startTime,
        'endTime': _endTime,
        'location': _locationController.text.isNotEmpty
            ? _locationController.text
            : 'No location specified',
        'type': _selectedSessionType,
        'attendance': true, // Default to present
      };

      setState(() {
        _sessions.add(newSession);
      });

      // Reset form
      _titleController.clear();
      _locationController.clear();
      _selectedDate = DateTime.now();
      _startTime = TimeOfDay(hour: 9, minute: 0);
      _endTime = TimeOfDay(hour: 10, minute: 0);
      _selectedSessionType = 'Class';

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Session scheduled successfully!'),
          backgroundColor: const Color(0xFF0A2463),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Toggle attendance
  void _toggleAttendance(String sessionId) {
    setState(() {
      final index = _sessions.indexWhere(
        (session) => session['id'] == sessionId,
      );
      if (index != -1) {
        _sessions[index]['attendance'] = !_sessions[index]['attendance'];
      }
    });
  }

  // Remove session
  void _removeSession(String sessionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Session'),
        content: const Text('Are you sure you want to remove this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _sessions.removeWhere((session) => session['id'] == sessionId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Session removed successfully'),
                  backgroundColor: Color(0xFFD90429),
                ),
              );
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Color(0xFFD90429)),
            ),
          ),
        ],
      ),
    );
  }

  // Edit session
  void _editSession(Map<String, dynamic> session) {
    _titleController.text = session['title'];
    _selectedDate = session['date'];
    _startTime = session['startTime'];
    _endTime = session['endTime'];
    _locationController.text = session['location'] == 'No location specified'
        ? ''
        : session['location'];
    _selectedSessionType = session['type'];

    // Remove the old session
    _removeSession(session['id']);

    // Scroll to form
    Scrollable.ensureVisible(
      _formKey.currentContext!,
      duration: const Duration(milliseconds: 500),
    );
  }

  // Build add session card
  Widget _buildAddSessionCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: const Color(0xFF0A2463),
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Schedule New Session',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A2463),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Session Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Session Title *',
                  labelStyle: const TextStyle(color: Color(0xFF0A2463)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF0A2463),
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.title, color: Color(0xFF0A2463)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a session title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date and Start Time
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: const Color(0xFF0A2463),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _formatDate(_selectedDate),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: InkWell(
                      onTap: () => _selectStartTime(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: const Color(0xFF0A2463),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _startTime.format(context),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // End Time and Location
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectEndTime(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: const Color(0xFF0A2463),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _endTime.format(context),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location (Optional)',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Session Type
              DropdownButtonFormField<String>(
                initialValue: _selectedSessionType,
                decoration: InputDecoration(
                  labelText: 'Session Type',
                  labelStyle: const TextStyle(color: Color(0xFF0A2463)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF0A2463),
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.category,
                    color: Color(0xFF0A2463),
                  ),
                ),
                items: _sessionTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSessionType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2463),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Schedule Session',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build weekly schedule
  Widget _buildWeeklySchedule() {
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0A2463),
              ),
            ),
            const SizedBox(height: 16),

            // Week days header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekDays.map((day) {
                final isToday = day == 'Wed'; // Example: Wednesday is today
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isToday
                            ? const Color(0xFF0A2463)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isToday ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateTime.now().day + weekDays.indexOf(day)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isToday ? const Color(0xFF0A2463) : Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Sessions for the week
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final session = _sessions[index];
                  final sessionColor = _getSessionTypeColor(session['type']);

                  return Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: sessionColor.withValues(),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: sessionColor.withValues()),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getSessionTypeIcon(session['type']),
                              color: sessionColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                session['type'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: sessionColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          session['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${session['startTime'].format(context)} - ${session['endTime'].format(context)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          session['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build session list
  Widget _buildSessionList() {
    if (_sessions.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.event_note, size: 60, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No sessions scheduled yet',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sessions.length,
      itemBuilder: (context, index) {
        final session = _sessions[index];
        final sessionColor = _getSessionTypeColor(session['type']);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Session header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: sessionColor.withValues(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            _getSessionTypeIcon(session['type']),
                            color: sessionColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          session['type'],
                          style: TextStyle(
                            fontSize: 14,
                            color: sessionColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Edit button
                        IconButton(
                          onPressed: () => _editSession(session),
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        // Remove button
                        IconButton(
                          onPressed: () => _removeSession(session['id']),
                          icon: Icon(
                            Icons.delete,
                            color: const Color(0xFFD90429),
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Session title
                Text(
                  session['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Date and time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(session['date']),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${session['startTime'].format(context)} - ${session['endTime'].format(context)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      session['location'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Attendance toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Attendance:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: session['attendance'],
                      onChanged: (value) => _toggleAttendance(session['id']),
                      activeThumbColor: const Color(0xFF0A2463),
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ],
                ),

                // Attendance status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: session['attendance']
                        ? const Color(0xFF0A2463).withValues()
                        : const Color(0xFFD90429).withValues(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        session['attendance']
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 16,
                        color: session['attendance']
                            ? const Color(0xFF0A2463)
                            : const Color(0xFFD90429),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        session['attendance'] ? 'Present' : 'Absent',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: session['attendance']
                              ? const Color(0xFF0A2463)
                              : const Color(0xFFD90429),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Academic Session Scheduler',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0A2463),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddSessionCard(),
              const SizedBox(height: 24),
              _buildWeeklySchedule(),
              const SizedBox(height: 24),
              const Text(
                'All Scheduled Sessions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2463),
                ),
              ),
              const SizedBox(height: 16),
              _buildSessionList(),
            ],
          ),
        ),
      ),
    );
  }
}
