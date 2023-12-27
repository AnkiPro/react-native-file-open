import type { EmitterSubscription } from 'react-native';

export type FileOpenedData = {
  url: string;
};

export type IFileOpening = {
  getOpenedFileURL(): Promise<string>;
  addListener(listener: (data: FileOpenedData) => void): EmitterSubscription;
};
