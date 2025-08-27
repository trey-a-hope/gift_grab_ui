import 'package:flutter/material.dart';
import 'package:gift_grab_ui/constants/lotties.dart';
import 'package:lottie/lottie.dart';

class NoResultsWidget extends StatelessWidget {
  final NoResultsEnum type;

  const NoResultsWidget(this.type, {super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.network(type.lottieUrl, height: 200),
      Text(type.name, style: Theme.of(context).textTheme.headlineLarge),
    ],
  );
}

enum NoResultsEnum {
  // Chat
  chatRooms('No chat rooms', Lotties.chat),
  // Friends
  blocked('No blocks', Lotties.friends),
  mutual('No friends', Lotties.friends),
  incomingRequest('No invites', Lotties.friends),
  outgoingRequest('No requests', Lotties.friends),
  // Groups
  allGroups('No groups', Lotties.groups),
  myGroups('No groups you belong to', Lotties.groups),
  // Tournament
  tournaments('No tournaments', Lotties.tournament),
  tournament('No records', Lotties.tournament),
  // Notifications
  notifications('No notifications', Lotties.notifications),
  // Leaderboard
  leaderboard('No records', Lotties.leaderboard),
  // Users
  users('No users found', Lotties.searchUsers);

  final String lottieUrl;
  final String name;

  const NoResultsEnum(this.name, this.lottieUrl);
}
