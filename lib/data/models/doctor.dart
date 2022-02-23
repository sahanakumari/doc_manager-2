

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_manager/data/app_data/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class Doctor {
  final int? id;
  final String? firstName;
  final String? lastName;
  String? profilePic;
  final bool? isFavourite;
  final String? primaryContactNo;
  final String? rating;
  final String? gender;
  final String? dob;
  final String? bloodGroup;
  final String? height;
  final String? weight;
  final String? email;
  final String? qualification;
  final String? description;
  final String? specialization;
  final String? languagesKnown;

  Doctor({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePic,
    this.isFavourite,
    this.primaryContactNo,
    this.rating,
    this.email,
    this.qualification,
    this.description,
    this.specialization,
    this.languagesKnown,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.height,
    this.weight,
  });

  Doctor copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? profilePic,
    bool? isFavourite,
    String? primaryContactNo,
    String? rating,
    String? email,
    String? qualification,
    String? description,
    String? specialization,
    String? languagesKnown,
    String? gender,
    String? dob,
    String? bloodGroup,
    String? height,
    String? weight,
  }) {
    return Doctor(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePic: profilePic ?? this.profilePic,
      isFavourite: isFavourite ?? this.isFavourite,
      primaryContactNo: primaryContactNo ?? this.primaryContactNo,
      rating: rating ?? this.rating,
      email: email ?? this.email,
      qualification: qualification ?? this.qualification,
      description: description ?? this.description,
      specialization: specialization ?? this.specialization,
      languagesKnown: languagesKnown ?? this.languagesKnown,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  String? get pic => profilePic;

  set pic(String? path) => profilePic = path;

  String get name => ((firstName ?? "n/a") + " " + (lastName ?? "")).trim();

  String? get initials {
    String letter = firstName?.substring(0, 1) ?? "";
    letter += lastName?.substring(0, 1) ?? "";
    return letter.isEmpty ? null : letter;
  }

  num get ratingNum {
    try {
      return double.parse(rating ?? "0");
    } catch (e) {
      return 0.0;
    }
  }

  Color get _ratingColor {
    if (ratingNum >= 4) return Colors.green;
    if (ratingNum >= 3) return Colors.orange;
    return Colors.red;
  }

  Widget get ratingWidgetCompact {
    if (rating == null) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: _ratingColor,
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
      ),
      width: 42,
      height: 18,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                rating!,
                textScaleFactor: 0.85,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(
              Remix.star_fill,
              size: 12,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget get avatar {
    if (profilePic?.isEmpty ?? true) {
      if (initials != null) {
        return Center(
          child: Text(
            initials!,
            textScaleFactor: 1.5,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }
      return const Center(child: Icon(Remix.user_3_fill, size: 40));
    }

    if (profilePic!.startsWith("https://") ||
        profilePic!.startsWith("http://")) {
      return CachedNetworkImage(
        imageUrl: profilePic!,
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.cover,
        errorWidget: (_, url, err) => const Center(
          child: Icon(
            Remix.landscape_fill,
            size: 48,
            color: Colors.grey,
          ),
        ),
        placeholder: (_, url) => const Center(
          child: CupertinoActivityIndicator(radius: 24),
        ),
      );
    }

    return Image.file(
      File(profilePic!),
      width: double.maxFinite,
      height: double.maxFinite,
      fit: BoxFit.cover,
    );
  }

  factory Doctor.fromJson(Map<String, dynamic>? jsonStr) {
    if (jsonStr == null) throw "noData";
    return Doctor(
      id: jsonStr["id"],
      firstName: jsonStr["first_name"],
      lastName: jsonStr["last_name"],
      profilePic: jsonStr["profile_pic"],
      isFavourite: jsonStr["favourite"],
      primaryContactNo: jsonStr["primary_contact_no"],
      rating: jsonStr["rating"],
      gender: jsonStr["gender"],
      dob: jsonStr["dob"],
      bloodGroup: jsonStr["blood_group"],
      height: jsonStr["height"],
      weight: jsonStr["weight"],
      email: jsonStr["email_address"],
      qualification: jsonStr["qualification"],
      description: jsonStr["description"],
      specialization: jsonStr["specialization"],
      languagesKnown: jsonStr["languagesKnown"],
    );
  }

  Map<String, dynamic> toJson(Doctor doctor) {
    return {
      "id": doctor.id,
      "first_name": doctor.firstName,
      "last_name": doctor.lastName,
      "profile_pic": doctor.profilePic,
      "primary_contact_no": doctor.primaryContactNo,
      "rating": doctor.rating,
      "gender": doctor.gender,
      "dob": doctor.dob,
      "blood_group": doctor.bloodGroup,
      "height": doctor.height,
      "weight": doctor.weight,
      "description": doctor.description,
      "specialization": doctor.specialization,
    };
  }

  @override
  bool operator ==(dynamic other) => id == other.id;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() => name;
}