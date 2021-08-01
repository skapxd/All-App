part of 'stores_service.dart';

class StoreCreateService extends UrlBase {
  StoreCreateService({
    String name,
    String iconPathCategory,
    String category,
    bool visibility,
    String description,
    ContactStore contactStore,
    void Function() onProgress,
    void Function({dynamic data}) onSuccess,
    void Function({dynamic data}) onFailed,
  }) {
    Map<String, dynamic> data = {};

    final setData = () {
      if (name != null) {
        data.addAll({'nameStore': name});
      }

      if (category != null) {
        data.addAll({'category': category});
      }

      if (category != null) {
        data.addAll({'iconPathCategory': iconPathCategory});
      }

      if (description != null) {
        data.addAll({'description': description});
      }

      if (visibility != null) {
        data.addAll({'visibility': visibility});
      }

      if (contactStore.telegram != null) {
        data.addAll({'telegram': contactStore.telegram});
      }

      if (contactStore.phonCall != null) {
        data.addAll({'phoneCall': contactStore.phonCall});
      }

      if (contactStore.whatsApp != null) {
        data.addAll({'whatsApp': contactStore.whatsApp});
      }
    };

    setData();

    if (onProgress != null) {
      onProgress();
    }

    _sendData(
      data: data,
      onFailed: onFailed,
      onProgress: onProgress,
      onSuccess: onSuccess,
    );
  }

  _sendData({
    Map<String, dynamic> data,
    void Function() onProgress,
    void Function({dynamic data}) onSuccess,
    void Function({dynamic data}) onFailed,
  }) async {
    dynamic res;

    try {
      //

      res = (await this.urlBase.post('/api-v1/stores', data: data)).data;
    } catch (e) {
      //

      if (onFailed != null) {
        onFailed();
      }
    }

    if (res['success'] && onSuccess != null) {
      onSuccess(data: res);
    } else if (!res['success'] && onFailed != null) {
      onFailed(data: res);
    }
  }

  // Future<void> createStore({
  //   String nameStore,
  //   String categoryStore,
  //   bool visibility,
  //   String description,
  //   ContactStore contactStore,
  //   void Function() onProgress,
  //   void Function({dynamic data}) onSuccess,
  //   void Function({dynamic data}) onFailed,
  // }) async {
  //   //

  //   Map<String, dynamic> data = {};

  //   final setData = () {
  //     if (nameStore != null) {
  //       data.addAll({'nameStore': nameStore});
  //     }

  //     if (categoryStore != null) {
  //       data.addAll({'category': categoryStore});
  //     }

  //     if (description != null) {
  //       data.addAll({'description': description});
  //     }

  //     if (visibility != null) {
  //       data.addAll({'visibility': visibility});
  //     }

  //     if (contactStore.telegram != null) {
  //       data.addAll({'telegram': contactStore.telegram});
  //     }

  //     if (contactStore.phonCall != null) {
  //       data.addAll({'phoneCall': contactStore.phonCall});
  //     }

  //     if (contactStore.whatsApp != null) {
  //       data.addAll({'whatsApp': contactStore.whatsApp});
  //     }
  //   };

  //   setData();

  //   if (onProgress != null) {
  //     onProgress();
  //   }

  //   dynamic res;

  //   try {
  //     //

  //     res = (await this.urlBase.post('/api-v1/stores', data: data)).data;
  //   } catch (e) {
  //     //

  //     if (onFailed != null) {
  //       onFailed();
  //     }
  //   }

  //   if (res['success'] && onSuccess != null) {
  //     onSuccess(data: res);
  //   } else if (!res['success'] && onFailed != null) {
  //     onFailed(data: res);
  //   }
  // }

}
