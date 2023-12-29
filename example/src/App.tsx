import React, { useEffect, useState } from 'react';

import { StyleSheet, Text, View } from 'react-native';
import FileOpening from '@ankipro/react-native-file-open';

export default function App() {
  const [openedFileUrl, setOpenedFileUrl] = useState(
    'There will be opened file URL. Drag & drop here any .zip file or open it from device file explorer.'
  );

  useEffect(() => {
    const onFileOpened = (uri: string) => {
      setOpenedFileUrl(uri);
    };

    FileOpening.getOpenedFileURL()
      .then(onFileOpened)
      .catch((err) => console.log('open err:', err));

    const subscription = FileOpening.addListener((data) => {
      onFileOpened(data.url);
    });

    return () => {
      subscription.remove();
    };
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.url}>{openedFileUrl}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  url: {
    textAlign: 'center',
    padding: 24,
  },
});
