import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// NOTE: Firebase functions에 대한 추가/수정을 진행하고나면 firebase deploy --only functions 명령어로 deploy가 필요
export const onVideoCreated = functions.firestore
  .document("videos/{videoID}")
  .onCreate(async (snapshot, context) => {
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    // NOTE: 영상 길이에 대한 제한 필요
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl, // 들어갈 영상
      "-ss",
      "00:00:01.000", // 1초 시간대 이동
      "-vframes",
      "1", // 프레임 추출
      "-vf",
      "scale=150:-1", // 썸네일 너비 150으로 축소 (높이는 비율에 맞게 자동 전환)
      "/tmp/${snapshot.id}.jpg", // 결과물을 tmp 폴더로 이동
    ]);
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload("/tmp/${snapshot.id}.jpg", {
      destination: "thumbnails/${snapshot.id}.jpg",
    });
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });
    const db = admin.firestore();

    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  });
