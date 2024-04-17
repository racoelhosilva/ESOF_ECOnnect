// Mocks generated by Mockito 5.4.4 from annotations
// in econnect/test/database_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:econnect/model/database.dart' as _i2;
import 'package:econnect/model/post.dart' as _i5;
import 'package:econnect/model/user.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [Database].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabase extends _i1.Mock implements _i2.Database {
  @override
  _i3.Future<String> storeImage(String? path) => (super.noSuchMethod(
        Invocation.method(
          #storeImage,
          [path],
        ),
        returnValue: _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #storeImage,
            [path],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #storeImage,
            [path],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<String> retrieveFileUrl(String? name) => (super.noSuchMethod(
        Invocation.method(
          #retrieveFileUrl,
          [name],
        ),
        returnValue: _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #retrieveFileUrl,
            [name],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #retrieveFileUrl,
            [name],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<void> addPost(_i5.Post? post) => (super.noSuchMethod(
        Invocation.method(
          #addPost,
          [post],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i5.Post>> getPosts() => (super.noSuchMethod(
        Invocation.method(
          #getPosts,
          [],
        ),
        returnValue: _i3.Future<List<_i5.Post>>.value(<_i5.Post>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i5.Post>>.value(<_i5.Post>[]),
      ) as _i3.Future<List<_i5.Post>>);

  @override
  _i3.Future<void> addUser(_i6.User? user) => (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [user],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i6.User?> getUser(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [id],
        ),
        returnValue: _i3.Future<_i6.User?>.value(),
        returnValueForMissingStub: _i3.Future<_i6.User?>.value(),
      ) as _i3.Future<_i6.User?>);
}
