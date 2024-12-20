defmodule TwitchStoryWeb.Controllers.ImageControllerTest do
  use TwitchStoryWeb.ConnCase

  alias TwitchStory.Games.Eurovision.Country
  alias TwitchStory.Games.Eurovision.Country.Services.Etl

  test "GET /images/eurovision/:code.png", %{conn: conn} do
    {:ok, country} = Country.create(%{name: "France", code: "FR"})

    Etl.extract_countries()

    conn = get(conn, ~p"/images/eurovision/#{country.code}")

    assert conn.status == 200

    assert conn.resp_body ==
             <<137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 64, 0, 0, 0,
               64, 8, 6, 0, 0, 0, 170, 105, 113, 222, 0, 0, 5, 226, 73, 68, 65, 84, 120, 218, 237,
               90, 187, 146, 27, 85, 16, 61, 221, 119, 100, 185, 120, 184, 40, 227, 128, 144, 42,
               138, 216, 95, 64, 72, 194, 39, 64, 76, 72, 198, 23, 56, 112, 2, 223, 66, 192, 55,
               64, 68, 81, 144, 16, 17, 16, 128, 1, 227, 114, 225, 101, 119, 189, 178, 52, 221,
               135, 224, 246, 189, 51, 218, 213, 216, 171, 213, 236, 90, 246, 78, 87, 105, 103,
               164, 149, 84, 211, 103, 78, 159, 62, 183, 175, 128, 41, 166, 152, 98, 138, 41, 166,
               152, 98, 138, 41, 166, 152, 226, 58, 134, 196, 177, 193, 199, 247, 87, 99, 126,
               241, 207, 95, 125, 50, 234, 133, 30, 126, 254, 217, 168, 223, 247, 209, 15, 191,
               204, 0, 180, 77, 60, 191, 9, 16, 223, 220, 251, 20, 127, 62, 89, 64, 68, 122, 216,
               108, 23, 243, 89, 194, 205, 89, 194, 221, 187, 239, 143, 122, 193, 203, 251, 95, 3,
               203, 37, 184, 90, 94, 232, 243, 4, 224, 36, 112, 251, 14, 126, 252, 242, 139, 200,
               25, 71, 77, 101, 0, 8, 35, 241, 232, 191, 5, 68, 244, 194, 0, 92, 86, 248, 131,
               223, 119, 250, 60, 1, 144, 132, 190, 115, 27, 172, 57, 199, 31, 0, 72, 2, 28, 28,
               47, 241, 232, 96, 1, 209, 221, 1, 32, 57, 46, 0, 7, 79, 118, 190, 30, 39, 33, 79,
               143, 65, 209, 250, 122, 211, 127, 211, 195, 131, 5, 142, 159, 181, 153, 1, 251, 69,
               0, 240, 228, 100, 71, 6, 16, 116, 194, 255, 125, 140, 254, 173, 233, 0, 160, 227,
               193, 227, 99, 152, 19, 34, 190, 119, 12, 160, 219, 238, 37, 224, 132, 61, 250, 7,
               236, 65, 208, 3, 128, 48, 119, 152, 57, 68, 101, 255, 0, 48, 223, 157, 1, 36, 224,
               14, 231, 38, 6, 128, 112, 143, 58, 113, 217, 187, 18, 0, 125, 4, 33, 33, 64, 14,
               151, 128, 121, 126, 136, 224, 181, 101, 128, 152, 193, 55, 151, 128, 195, 157, 48,
               35, 68, 25, 85, 179, 71, 93, 96, 71, 13, 200, 41, 58, 132, 28, 40, 129, 104, 19,
               230, 14, 225, 238, 54, 96, 124, 6, 140, 32, 130, 36, 64, 31, 42, 1, 195, 170, 109,
               123, 37, 176, 103, 0, 184, 239, 12, 128, 187, 35, 153, 195, 56, 80, 2, 116, 194,
               11, 0, 34, 175, 29, 0, 133, 1, 3, 0, 16, 230, 12, 31, 16, 26, 32, 123, 212, 10,
               124, 215, 46, 144, 59, 128, 155, 61, 191, 11, 172, 90, 131, 106, 111, 185, 120, 65,
               16, 246, 77, 3, 60, 52, 14, 131, 34, 232, 45, 218, 214, 96, 150, 141, 130, 244,
               252, 242, 171, 14, 64, 161, 63, 73, 176, 109, 135, 75, 160, 53, 235, 117, 1, 246,
               238, 190, 236, 129, 6, 216, 133, 147, 143, 244, 224, 238, 160, 15, 106, 128, 161,
               53, 67, 219, 122, 246, 1, 162, 57, 237, 11, 130, 48, 186, 15, 184, 32, 3, 202, 101,
               16, 89, 224, 105, 6, 219, 168, 1, 110, 176, 40, 1, 37, 192, 48, 3, 149, 5, 34, 175,
               92, 9, 240, 212, 66, 200, 73, 208, 12, 237, 70, 6, 184, 193, 172, 173, 12, 168, 51,
               1, 145, 208, 3, 190, 82, 0, 240, 212, 185, 5, 0, 62, 92, 2, 45, 150, 39, 199, 88,
               158, 56, 52, 37, 136, 38, 0, 2, 70, 39, 216, 86, 15, 14, 15, 15, 71, 5, 224, 232,
               217, 114, 75, 0, 216, 117, 191, 152, 118, 25, 137, 213, 98, 49, 192, 128, 104, 131,
               140, 69, 83, 180, 2, 136, 8, 8, 1, 176, 93, 87, 72, 41, 141, 10, 64, 186, 192, 106,
               176, 170, 127, 136, 1, 157, 144, 161, 229, 48, 221, 186, 197, 80, 161, 190, 50,
               251, 33, 21, 72, 197, 244, 124, 12, 144, 145, 77, 148, 108, 89, 82, 117, 57, 19,
               237, 175, 154, 41, 247, 97, 6, 228, 54, 8, 8, 36, 15, 69, 8, 16, 2, 89, 243, 5, 28,
               61, 185, 177, 157, 96, 73, 152, 213, 0, 1, 22, 22, 216, 221, 6, 52, 192, 115, 7,
               48, 35, 224, 128, 164, 236, 5, 32, 26, 7, 130, 44, 131, 18, 185, 122, 17, 108, 219,
               237, 168, 223, 3, 160, 12, 68, 157, 132, 183, 6, 219, 60, 17, 2, 204, 61, 3, 173,
               14, 88, 78, 182, 76, 200, 133, 10, 145, 174, 175, 94, 253, 64, 104, 59, 13, 160,
               148, 197, 15, 145, 15, 236, 140, 208, 240, 64, 196, 209, 26, 106, 221, 3, 236, 102,
               3, 89, 22, 114, 73, 200, 75, 96, 192, 54, 0, 144, 128, 148, 81, 56, 106, 251, 115,
               70, 158, 155, 74, 64, 152, 223, 96, 238, 33, 30, 82, 119, 136, 114, 226, 132, 170,
               102, 236, 36, 202, 225, 10, 1, 192, 22, 62, 128, 82, 198, 127, 29, 253, 25, 64,
               100, 43, 188, 169, 11, 20, 148, 220, 33, 16, 80, 60, 236, 176, 7, 3, 20, 158, 33,
               140, 214, 200, 189, 45, 129, 66, 255, 210, 2, 233, 132, 199, 190, 0, 95, 52, 19,
               204, 83, 225, 156, 52, 69, 160, 96, 136, 161, 131, 18, 34, 72, 92, 125, 9, 156,
               211, 7, 176, 167, 130, 89, 4, 189, 106, 0, 221, 107, 89, 156, 45, 1, 116, 86, 17,
               34, 128, 228, 253, 1, 139, 61, 18, 209, 4, 208, 66, 21, 159, 223, 8, 244, 50, 218,
               36, 207, 7, 108, 97, 38, 73, 120, 30, 4, 192, 99, 228, 79, 18, 226, 67, 99, 241,
               120, 83, 221, 25, 18, 205, 179, 120, 13, 83, 195, 14, 152, 77, 217, 247, 133, 145,
               194, 203, 91, 14, 243, 57, 44, 19, 172, 39, 223, 171, 255, 92, 18, 14, 14, 137, 96,
               217, 48, 40, 31, 174, 206, 63, 196, 67, 52, 59, 68, 178, 116, 131, 83, 73, 247,
               174, 69, 47, 87, 12, 78, 231, 219, 97, 194, 158, 245, 45, 54, 216, 89, 247, 4, 232,
               204, 99, 241, 97, 6, 120, 118, 130, 90, 166, 66, 181, 56, 178, 59, 140, 89, 161,
               168, 70, 194, 172, 227, 179, 117, 218, 143, 95, 2, 155, 24, 85, 250, 252, 58, 8,
               236, 28, 96, 136, 103, 191, 35, 228, 231, 3, 12, 200, 117, 226, 160, 107, 110, 117,
               112, 192, 243, 114, 56, 139, 135, 231, 149, 97, 79, 69, 106, 59, 148, 2, 68, 126,
               140, 222, 6, 11, 210, 177, 191, 87, 191, 191, 36, 22, 55, 160, 107, 123, 25, 0,
               175, 11, 188, 110, 111, 112, 88, 3, 98, 50, 92, 84, 31, 162, 249, 174, 43, 195,
               139, 11, 68, 163, 53, 66, 160, 122, 182, 37, 136, 40, 84, 101, 124, 13, 8, 0, 234,
               22, 153, 72, 110, 141, 165, 198, 221, 234, 170, 175, 218, 222, 88, 212, 26, 189,
               46, 139, 49, 84, 2, 69, 28, 122, 192, 66, 21, 185, 103, 58, 33, 26, 37, 193, 146,
               242, 250, 196, 72, 163, 59, 52, 73, 208, 168, 158, 113, 139, 5, 16, 17, 89, 59, 63,
               239, 255, 37, 53, 161, 59, 6, 172, 216, 169, 125, 176, 143, 206, 181, 59, 157, 141,
               143, 215, 182, 88, 218, 33, 122, 101, 179, 6, 64, 82, 65, 18, 65, 83, 56, 92, 188,
               111, 108, 146, 104, 202, 115, 1, 85, 196, 157, 23, 168, 8, 154, 148, 47, 114, 86,
               142, 141, 98, 150, 116, 144, 1, 253, 215, 7, 235, 122, 211, 249, 124, 158, 79, 86,
               171, 92, 219, 16, 80, 90, 192, 218, 156, 108, 220, 109, 186, 231, 1, 136, 228, 242,
               116, 4, 67, 160, 25, 28, 17, 160, 55, 171, 168, 0, 52, 170, 184, 115, 107, 142,
               249, 60, 156, 158, 104, 252, 82, 36, 63, 52, 165, 40, 9, 193, 124, 214, 224, 141,
               121, 131, 27, 141, 98, 62, 75, 72, 42, 184, 209, 100, 6, 204, 155, 132, 89, 35,
               163, 11, 96, 250, 224, 195, 124, 190, 90, 65, 150, 75, 208, 12, 92, 45, 97, 79,
               159, 2, 237, 42, 143, 204, 98, 242, 235, 225, 26, 235, 178, 56, 132, 81, 73, 200,
               237, 119, 33, 233, 183, 179, 0, 204, 223, 124, 27, 15, 127, 253, 9, 26, 244, 149,
               176, 191, 245, 23, 99, 49, 35, 20, 17, 44, 32, 56, 120, 129, 217, 249, 246, 214,
               31, 163, 130, 240, 236, 187, 239, 215, 146, 42, 58, 220, 221, 225, 206, 225, 57,
               123, 37, 194, 83, 211, 161, 191, 30, 66, 102, 179, 51, 253, 234, 45, 0, 239, 197,
               241, 58, 196, 17, 128, 191, 1, 28, 73, 143, 9, 55, 79, 207, 7, 94, 227, 104, 1, 44,
               226, 56, 197, 20, 83, 76, 113, 125, 67, 248, 178, 198, 188, 123, 18, 122, 221, 25,
               48, 1, 48, 1, 112, 205, 227, 127, 244, 75, 255, 98, 130, 43, 114, 176, 0, 0, 0, 0,
               73, 69, 78, 68, 174, 66, 96, 130>>
  end
end
