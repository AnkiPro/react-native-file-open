import {
  NativeEventEmitter,
  NativeModules,
  Platform,
  type EmitterSubscription,
} from 'react-native';
import type { FileOpenedData, IFileOpening } from './types';

const LINKING_ERROR =
  `The package '@ankipro/react-native-file-open' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n';

const FileOpeningModule = NativeModules.FileOpeningModule
  ? NativeModules.FileOpeningModule
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const FileOpening: IFileOpening = {
  getOpenedFileURL: FileOpeningModule.getOpenedFileURL,

  addListener: (
    listener: (data: FileOpenedData) => void
  ): EmitterSubscription => {
    const eventEmitter = new NativeEventEmitter(FileOpeningModule);
    return eventEmitter.addListener('FileOpened', listener);
  },
};

export default FileOpening;

export type * from './types';
