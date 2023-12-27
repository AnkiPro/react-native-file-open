import React, { useEffect } from 'react';

import { StyleSheet, View } from 'react-native';
import FileOpening from '@ankipro/react-native-file-open';

export default function App() {
  useEffect(() => {
    const onFileOpened = (uri: string) => {
      console.log(uri);
    };

    FileOpening.getOpenedFileURL().then(onFileOpened);

    const subscription = FileOpening.addListener((data) => {
      onFileOpened(data.url);
    });

    return () => {
      subscription.remove();
    };
  }, []);

  return <View style={styles.container} />;
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
